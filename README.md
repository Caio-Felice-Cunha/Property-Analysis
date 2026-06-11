# Property Analysis

Property Analysis with the Chi-Square Test in R.

[Script](https://github.com/Caio-Felice-Cunha/Property-Analysis/blob/main/Property%20Analysis.R) <br>
[R Markdown source](https://github.com/Caio-Felice-Cunha/Property-Analysis/blob/main/Property-Analysis.Rmd) <br>
[The report (PDF)](https://github.com/Caio-Felice-Cunha/Property-Analysis/blob/main/Property-Analysis.pdf)

![house-1836070__480](https://user-images.githubusercontent.com/111542025/236896469-f4173b35-715e-4eca-9ccb-ffc75bd453e2.jpg)

## This is the 1st version

## Business Problem
> Data source: a dummy dataset built by Data Science Academy.

The dataset has 7,700 properties and 7 columns (price, size, zip code, type,
status, rent status, city). The job is to check whether two categorical
variables, property type (`Type_Property`) and property status (`Status_Property`,
New vs Old), are related. The test for a relationship between two categorical
variables is the Chi-Square test of independence.

## Solution Strategy
Built in RStudio with base R (no extra packages).
* Step 01: Collect the data and understand it.
* Step 02: Define the hypotheses.
* Step 03: Run the test, on the full data and again with apartments removed.

The hypotheses:
* H0: property type and status are independent (no relationship).
* H1: they are related.

We reject H0 when the p-value is below 0.05.

## Results

**Full dataset:** `X-squared = 868.75, df = 4, p-value < 2.2e-16`. The p-value is
far below 0.05, so H0 is rejected. Property type and status are related.

**Excluding apartments:** `X-squared = 0.79718, df = 3, p-value = 0.8501`. The
p-value is well above 0.05, so H0 is not rejected. Among the non-apartment types
there is no detectable association.

**Interpretation:** the overall relationship is driven entirely by apartments.
Apartments are disproportionately New, so they pull the whole table. Once they
are removed, the relationship disappears.

Counts behind the result (New / Old):

| Type | New | Old |
|---|---|---|
| Apartment | 990 | 2,901 |
| House With Backyard | 7 | 357 |
| House without Backyard | 19 | 961 |
| Other | 14 | 656 |
| Penthouse Apartment | 43 | 1,752 |

(Numbers quoted from `Property-Analysis.pdf` and reproduced from `data.csv`.)

## How to Run

Requires R >= 4.0. From the repo root:

```bash
Rscript "Property Analysis.R"
```

Or open `Property Analysis.R` in RStudio and run it, or knit `Property-Analysis.Rmd`
to regenerate the PDF report.

You can confirm the two test statistics without R using the included Python check
(needs scipy):

```bash
python verify.py
```

It reads `data.csv`, recomputes both chi-square statistics with
`scipy.stats.chi2_contingency`, and prints `OK` when they match the report.

## Next Steps
* Improve the parameters.
* Understand the correlation between variables.

## Disclaimer
A good part of this project was done as part of the Data Science Academy "Big
Data Analytics with R and Microsoft Azure Machine Learning" course (part of the
Data Scientist training).
