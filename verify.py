"""Cross-language check of the chi-square results in data.csv.

Reproduces the two statistics published in Property-Analysis.pdf using
scipy, so the findings can be confirmed without an R install. Run it from
the repo root:

    python verify.py

It exits 0 and prints "OK" when the numbers match the report; it exits 1
with a diff if they ever drift (for example, if data.csv is regenerated).

Only dependency: scipy (pip install scipy).
"""

import csv
import sys
from collections import Counter

from scipy.stats import chi2_contingency

# Expected values from Property-Analysis.pdf (R's chisq.test output).
EXPECTED = {
    "full": {"chi2": 868.75, "dof": 4},
    "no_apartment": {"chi2": 0.79718, "dof": 3, "p": 0.8501},
}


def contingency(rows, row_key, col_key):
    """Build a contingency table as a list of lists, with sorted labels."""
    row_labels = sorted({r[row_key] for r in rows})
    col_labels = sorted({r[col_key] for r in rows})
    row_idx = {label: i for i, label in enumerate(row_labels)}
    col_idx = {label: i for i, label in enumerate(col_labels)}
    table = [[0] * len(col_labels) for _ in row_labels]
    for r in rows:
        table[row_idx[r[row_key]]][col_idx[r[col_key]]] += 1
    return row_labels, col_labels, table


def run_test(rows):
    _, _, table = contingency(rows, "Type_Property", "Status_Property")
    # correction=False matches R's chisq.test for tables larger than 2x2.
    chi2, p, dof, _ = chi2_contingency(table, correction=False)
    return chi2, p, dof


def main():
    with open("data.csv", encoding="utf-8") as fh:
        rows = list(csv.DictReader(fh))

    print(f"Rows: {len(rows)}")
    print("Type counts:", dict(Counter(r["Type_Property"] for r in rows)))
    print("Status counts:", dict(Counter(r["Status_Property"] for r in rows)))

    failures = []

    chi2, p, dof = run_test(rows)
    print(f"\nFull dataset:        chi2={chi2:.5g}  dof={dof}  p={p:.3g}")
    if round(chi2, 2) != EXPECTED["full"]["chi2"] or dof != EXPECTED["full"]["dof"]:
        failures.append("full dataset statistic does not match the report")

    no_apt = [r for r in rows if r["Type_Property"] != "Apartment"]
    chi2b, pb, dofb = run_test(no_apt)
    print(f"Excluding apartments: chi2={chi2b:.5g}  dof={dofb}  p={pb:.4g}")
    exp = EXPECTED["no_apartment"]
    if (
        round(chi2b, 5) != exp["chi2"]
        or dofb != exp["dof"]
        or round(pb, 4) != exp["p"]
    ):
        failures.append("no-apartment statistic does not match the report")

    if failures:
        print("\nMISMATCH:")
        for f in failures:
            print(f"  - {f}")
        sys.exit(1)

    print("\nOK: both statistics match Property-Analysis.pdf.")


if __name__ == "__main__":
    main()
