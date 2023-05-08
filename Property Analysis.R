# Property Analysis with Chi-Square Test

# Test Assumption:
# Variables must be independent!



# Loading the dataset
df = read.csv("data.csv")

# Visualizing the data
View(df)

# Dimensions
dim(df)

# Separating x and y
x <- df$Type_Property
y <- df$Status_Property

# Separately select the x and y
unique(x)
unique(y)

# values cross table
table(x,y)

# percentage cross table
round(prop.table(table(x,y))*100,2)

# Defining the hypotheses:

# H0 = There is no relationship between x and y
# H1 = x and y are related

# If the p-value is less than 0.05 we reject the H0
# Chi-Square Test
?chisq.test
chisq.test(x,y)
chisq.test(table(x, y))

# Exercise:

# If we do not consider Apartment type properties, is there a difference in the test result?

## Way of Gaius

## Create the tables filtering to remove the "apartment"
x <- df$Type_Property[df$Type_Property != "Apartment"]
y <- df$Status_Property[df$Type_Property != "Apartment"]

# Seeing unique distinct data from tables
unique(x)
unique(y)

# Making cross tables
table(x,y)
round(prop.table(table(x,y))*100,2)

# Chi-Square test with the new database
?chisq.test
chisq.test(x,y)
chisq.test(table(x,y))