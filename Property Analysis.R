# Property Analysis with Chi-Square Test

# Chi-square test of independence.
# H0: the two categorical variables ARE independent (no relationship).
# H1: the two variables are related.
# Assumptions: observations are independent, and every expected cell
# count is >= 5. If the p-value is below 0.05 we reject H0.

# Requires R >= 4.0 (relies on the modern stringsAsFactors = FALSE default).

# Loading the dataset (set the working directory to the repo root first)
df = read.csv("data.csv")

# Visualizing the data (non-interactive; use View(df) in RStudio if preferred)
print(str(df))
print(head(df))

# Dimensions
print(dim(df))

# Separating x and y
x <- df$Type_Property
y <- df$Status_Property

# Separately select the x and y
print(unique(x))
print(unique(y))

# values cross table
print(table(x, y))

# percentage cross table
print(round(prop.table(table(x, y)) * 100, 2))

# Defining the hypotheses:

# H0 = There is no relationship between x and y
# H1 = x and y are related

# If the p-value is less than 0.05 we reject the H0
# Chi-Square Test
print(chisq.test(x, y))
print(chisq.test(table(x, y)))

# Exercise:

# If we do not consider Apartment type properties, is there a difference in the test result?

## Way of Gaius

## Create the tables filtering to remove the "apartment".
## droplevels() drops the now-empty "Apartment" level so the test runs
## cleanly even under older R (stringsAsFactors = TRUE) defaults.
x <- droplevels(df$Type_Property[df$Type_Property != "Apartment"])
y <- droplevels(df$Status_Property[df$Type_Property != "Apartment"])

# Seeing unique distinct data from tables
print(unique(x))
print(unique(y))

# Making cross tables
print(table(x, y))
print(round(prop.table(table(x, y)) * 100, 2))

# Chi-Square test with the new database
print(chisq.test(x, y))
print(chisq.test(table(x, y)))
