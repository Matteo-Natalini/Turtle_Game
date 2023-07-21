## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
library(tidyverse)

# Import the data set.
turtle_sales <- read_csv("turtle_sales.csv")

# Print the data frame.
View(turtle_sales)

# View size
dim(turtle_sales)


# Change Product to factor

turtle_sales$Product <- factor(turtle_sales$Product)


# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns (Ranking, Year, Genre, Publisher)
turtle_sales_clean <- select(turtle_sales, -Ranking, -Year, -Genre, -Publisher)


# Sense check data frame
dim(turtle_sales_clean)


# Search for missing values in a data set.
sum(is.na(turtle_sales_clean))


# View the data frame.
head(turtle_sales_clean)


# View the descriptive statistics.
summary(turtle_sales_clean)



# Check Product

class(turtle_sales_clean$Product)


################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots

# Create a scatterplot of 'Global_Sales' versus 'NA_Sales' and 'EU_Sales' 
# to see how the overall sales relate to the sales in each region.
qplot(Global_Sales, NA_Sales, data=turtle_sales_clean, geom=c('point', 'smooth'))


# Remove outlier to have a better view of the plots
sales_no_outlier <- filter(turtle_sales_clean, Global_Sales<60)


# Same scatterplot without outlier.
qplot(Global_Sales, NA_Sales, data=sales_no_outlier, geom=c('point', 'smooth'))

qplot(Global_Sales, EU_Sales, data=sales_no_outlier, geom=c('point', 'smooth'))


# Platforms are in different colours to spot trends.
qplot(Global_Sales, NA_Sales, data=sales_no_outlier, color=Platform)

qplot(Global_Sales, EU_Sales, color=Platform, data=sales_no_outlier)

# Create a scatterplot of 'NA_Sales' versus 'EU_Sales' to see how the sales in 
# North America relate to the sales in Europe.
qplot(EU_Sales, NA_Sales, data=sales_no_outlier)

# While NA_Sales and EU_Sales look correlated with Global_sales, they don't seem
# correlated with each others.

## 2b) Histograms

# Create histogram of Global Sales.
qplot(Global_Sales, bins=15, data=turtle_sales_clean)  +
  scale_x_continuous(breaks = seq(0, max(turtle_sales_clean$Global_Sales), by = 2))

# Create histogram of EU_Sales
qplot(EU_Sales, bins=15, data=turtle_sales_clean) +
  scale_x_continuous(breaks = seq(0, max(turtle_sales_clean$EU_Sales), by = 1))

# Create histogram of NA_Sales
qplot(NA_Sales, bins=15, data=turtle_sales_clean) +
  scale_x_continuous(breaks = seq(0, max(turtle_sales_clean$NA_Sales), by = 1))



## 2c) Boxplots

# Create boxplots for Global sales
qplot(Global_Sales, data=turtle_sales_clean, geom='boxplot')

# Create boxplots for EU_Sales
qplot(EU_Sales, data=turtle_sales_clean, geom='boxplot')

# Create boxplots for NA_Sales
qplot(NA_Sales, data=turtle_sales_clean, geom='boxplot')

# Create a boxplot of Global sales Vs Platforms
qplot(Platform, Global_Sales, data=turtle_sales_clean, geom='boxplot')

## 3) Barplot

qplot(Global_Sales, Platform, data=turtle_sales_clean, geom='col')


###############################################################################

# 3. Observations and insights

## Your observations and insights here ......

# It is possible to notice a strong positive correlation between Global Sales 
# and NA_Sales.
# The correlation between Global sale and EU is still positive but less strong.
# Between NA and EU sales looks like there is not particular correlation.
# There is one outlier emerging in the boxplot that has been removed for a 
# clearer view of the plot but I  kept it when making calculations about sales.
# The highest sales come from the games from the platform Wii, followed by X360 
# and PS3.



###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and manipulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 3. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 4. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 5. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 6. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
head(turtle_sales_clean)

# Create statistical summaries.
library(skimr)
# Create a report as an HTML file.
library(DataExplorer)


# Check output: Determine the min, max, and mean values.
summary(turtle_sales_clean)

# View the descriptive statistics.
skim(turtle_sales_clean)

# Create a report as an HTML file.
DataExplorer::create_report(turtle_sales_clean)

###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.
# Group data based on Product, Plaform and Genre, and determine the sum of sales.
sales_by_product <- turtle_sales %>%
  group_by(Product, Platform, Genre) %>%
  summarise(Sum_NA_Sales = sum(NA_Sales),
            Sum_EU_Sales = sum(EU_Sales),
            Sum_Global_Sales = sum(Global_Sales))



# View the data frame.
head(sales_by_product)

# Explore the data frame.
dim(sales_by_product)

# View the descriptive statistics.
skim(sales_by_product)


## 2b) Determine which plot is the best to compare game sales.


# Create scatterplots.
ggplot(sales_by_product, aes(x = Sum_NA_Sales, y = Sum_EU_Sales)) +
  geom_point() +
  labs(x = "Sales in North America", 
       y = "Sales in Europe", 
       title = "Regional Sales comparison")


# Create histograms.
# create histogram for Sum_NA_Sales
hist1 <- ggplot(sales_by_product, aes(x = Sum_NA_Sales)) +
  geom_histogram()


# create histogram for Sum_EU_Sales
hist2 <- ggplot(sales_by_product, aes(x = Sum_EU_Sales)) +
  geom_histogram()

# create histogram for Sum_Global_Sales
hist3 <-ggplot(sales_by_product, aes(x = Sum_Global_Sales)) +
  geom_histogram()


# Arrange histograms side by side
library(gridExtra)

grid.arrange(hist1, hist2, hist3, ncol = 3)


# Create boxplots.
# create boxplot for Sum_NA_Sales
box1 <- ggplot(sales_by_product, aes(y = Sum_NA_Sales)) +
  geom_boxplot() +
  coord_flip()

# create boxplot for Sum_EU_Sales
box2 <- ggplot(sales_by_product, aes(y = Sum_EU_Sales)) +
  geom_boxplot() +
  coord_flip()

# create boxplot for Sum_Global_Sales
box3 <- ggplot(sales_by_product, aes(y = Sum_Global_Sales)) +
  geom_boxplot() +
  coord_flip()

# Arrange boxplots side by side
grid.arrange(box1, box2, box3, nrow = 3)

###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots

# Global Sales
qqnorm(sales_by_product$Sum_Global_Sales)

qqline(sales_by_product$Sum_Global_Sales)


# European Sales
qqnorm(sales_by_product$Sum_EU_Sales)

qqline(sales_by_product$Sum_EU_Sales)


#North American Sales
qqnorm(sales_by_product$Sum_NA_Sales)

qqline(sales_by_product$Sum_NA_Sales)

## 3b) Perform Shapiro-Wilk test
# Global Sales
shapiro.test(sales_by_product$Sum_Global_Sales)

# European Sales
shapiro.test(sales_by_product$Sum_EU_Sales)

shapiro.test(sales_by_product$Sum_NA_Sales)



## 3c) Determine Skewness and Kurtosis

# Install the moments package and load the library.
# install.packages('moments') 

library(moments)


# Skewness and Kurtosis.

# Global Sales
skewness(sales_by_product$Sum_Global_Sales)

kurtosis(sales_by_product$Sum_Global_Sales)

# European Sales
skewness(sales_by_product$Sum_EU_Sales)

kurtosis(sales_by_product$Sum_EU_Sales)

#North American Sales
skewness(sales_by_product$Sum_NA_Sales)

kurtosis(sales_by_product$Sum_NA_Sales)



## 3d) Determine correlation
# Determine correlation.
cor(sales_by_product$Sum_Global_Sales, sales_by_product$Sum_EU_Sales)

cor(sales_by_product$Sum_Global_Sales, sales_by_product$Sum_NA_Sales)

cor(sales_by_product$Sum_NA_Sales, sales_by_product$Sum_EU_Sales)


###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.
# Choose the type of plot you think best suits the data set and what you want 
# to investigate. Explain your answer in your report.



# 4.1 Investigate product and global sales.

# Create bar plot for global sales per platform.
ggplot(sales_by_product, aes(x = Platform, y = Sum_Global_Sales)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Global Sales by Platform",
       x = "Platform",
       y = "Global Sales") +
  theme_minimal()


# Create bar plot for global sales per genre.
ggplot(sales_by_product, aes(x = Genre, y = Sum_Global_Sales)) +
  geom_bar(stat = "identity", fill = "seagreen3") +
  labs(title = "Global Sales by Genre",
       x = "Genre",
       y = "Global Sales") +
  theme_minimal()


# Create density plot with revenue for the more popular platforms.
ggplot(subset(sales_by_product, Platform %in% c("Wii", "X360", "PS3", "DS")),
       aes(x = Sum_Global_Sales, fill = Platform)) +
  geom_density(alpha = 0.5) +
  labs(title = "Global Sales Density Plot by Platform",
       x = "Global Sales",
       y = "Density") +
  theme_minimal()


################################################################################


# View the outlier best seller with more then 60 million revenue.
sales_by_product[sales_by_product$Sum_Global_Sales > 60, ]


################################################################################


# Create a box plot with Platform and Sum_Global_Sales
ggplot(sales_by_product, aes(x = Platform, y = Sum_Global_Sales)) +
  geom_boxplot(fill = "springgreen3", alpha = 0.8) +
  labs(title = "Total Global Sales by Platform",
       x = "Platform", y = "Total Global Sales (in millions)") +
  theme(plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        legend.position = "none")



# Create barplot with Global_Sales by genre and platforms
ggplot(sales_by_product, aes(x = Genre, y = Sum_Global_Sales, fill = Platform)) +
  geom_col() +
  labs(title = "Global Sales by Genre and Platform",
       x = "Genre",
       y = "Global Sales",
       fill = "Platform") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  scale_y_continuous(labels = scales::comma_format()) +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))


################################################################################


# Create the bar plot to compare EU, NA and Global sales by platform 

# Install "reshape2" package to use 'melt' function and convert regional sales in factors
# install.packages("reshape2")
library(reshape2)

# Drop Product column
sales_platforms <- select(turtle_sales_clean, -Product)

# View data frame
head(sales_platforms)

# Melt sales and create a categorical column "Region"
sales_platforms <- melt(sales_platforms)

# View data frame
head(sales_platforms)

#Rename columns
names(sales_platforms)[3] <- "Sales"

names(sales_platforms)[2] <- "Region"

# create a barplot with bars side by side with "dodge"
barplot_platforms <- ggplot(sales_platforms, aes(x = Platform, y= Sales, fill = Region)) +
  labs(x = "Platform", y = "Sales", title = "Global, NA, and EU Sales by Platform") +
  geom_bar(stat="summary", fun = "sum", width=.8, position = "dodge")

# Add interactivity with ggplotly
ggplotly(barplot_platforms)


################################################################################


# Create the bar plot to compare EU, NA and Global sales by genre 
# install.packages("reshape2")
library(reshape2)

# Drop Product column
sales_platforms2 <- select(turtle_sales, -Ranking, -Year, -Product, -Publisher,
                           - Platform)

# View data frame
head(sales_platforms2)

# Melt sales and create a categorical column "Region"
sales_platforms2 <- melt(sales_platforms2)

# View data frame
head(sales_platforms2)

#Rename columns
names(sales_platforms2)[3] <- "Sales"

names(sales_platforms2)[2] <- "Region"

# create a barplot with bars side by side with "dodge"
ggplot(sales_platforms2, aes(x = Genre, y= Sales, fill = Region)) +
  labs(x = "Genre", y = "Sales", title = "Global, NA, and EU Sales by Platform") +
  geom_bar(stat="summary", fun = "sum", width=.8, position = "dodge") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


################################################################################

##### Creating a new dataframe with a column with the rest of the sales in the world


# Create a new dataframe
all_sales <- sales_by_product


# Create the other_sales column
all_sales['Other_sales'] = round(all_sales['Sum_Global_Sales'] - 
                                   (all_sales['Sum_NA_Sales'] + all_sales['Sum_EU_Sales']), 2)


# group the dataframe by Platform and sum the other_sales column
platform_sales <- all_sales %>% group_by(Platform) %>% summarize(total_other_sales = sum(Other_sales))


# create the barplot
ggplot(platform_sales, aes(x = Platform, y = total_other_sales)) +
  geom_bar(stat = "identity") +
  xlab("Platform") +
  ylab("Other Sales") +
  ggtitle("Other Sales by Platform")


################################################################################

# Create a 3D scatterplot with Plotly to compare Global, European and North
# American Sales by Genre.

# Install plotly package
# install.packages("plotly")

library(plotly)

# Create the plot
plot_ly(sales_by_product, x = ~Sum_Global_Sales, y = ~Sum_EU_Sales, z = ~Sum_NA_Sales,
        color = ~Genre, colors = "Set1", size = ~Sum_Global_Sales,
        type = "scatter3d", mode = "markers") %>%
  layout(scene = list(xaxis = list(title = "Global Sales"),
                      yaxis = list(title = "Sales in Europe"),
                      zaxis = list(title = "Sales in North America")),
         title = "3D Scatter Plot of Sales by Genre")


################################################################################


# 4.2 Create scatter plot with trend line

# Plotting how global sales correlate with North American sales.
ggplot(sales_by_product, aes(x = Sum_NA_Sales, y = Sum_Global_Sales)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE, color = "darkorange") +
  labs(x = "Sales in North America", 
       y = "Global Sales", 
       title = "Global Sales vs NA Sales")

# Plotting how global sales correlate with European sales.
ggplot(sales_by_product, aes(x = Sum_EU_Sales, y = Sum_Global_Sales)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE, color = "darkorange") +
  labs(x = "Sales in Europe", 
       y = "Global Sales", 
       title = "Gobal Sales vs EU Sales")




###############################################################################

# 5. Observations and insights
# Your observations and insights here...

# First the data has been grouped in order to sum the values of the sales
# by product ID. From the QQ plot was already visible that the data of sales
# were not normally distributed and this has been confirmed by the Shapiro-Wilk
# test that gave a p value smaller the 0.5 for all the variables. The density
# plots suggest a positive skewness in all three the group of sales, hypothesis
# confirmed by the positive skewness values. The groups of sale data have all
# heavy tails and are more peaked than a normal distribution. This is evinced
# also from the very high kurtosis values. There are many outliers.
# There is a strong positive correlation between sales.

# It is interesting in the barchart of the sales by platform to see that the
# European market follow the same ranking of best revenue produces of the global
# sales with Wii at the first place, than X360 and PS3, but NA sale see X360 at
# the first place followed by Wii and PS3

# The best seller game with a massive difference from the other revenue is the 
# sport game for Wii. Nevertheless, sport in the list of the most sold genre is not 
# in the first three, but shooter and action games are the most popular.
# We can also see that each genre has a prefered platform: The PS platforms are the
# most popular for action games, and shooter games with X360. Wii leading in the sports.


###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explor the data
# View data frame created in Week 5.
head(sales_by_product)

# Determine a summary of the data frame.
summary(sales_by_product)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns

# Import the psych package.
library(psych)

# Look at the correlation between Sales grouped by product
cor(just_sales)

# Visualize the correlations.
corPlot(just_sales, cex=2)

# Create a linear regression model between Global sales and North American sales.
# The two variables with the strongest correlation (0.93)
model1 <- lm(Sum_Global_Sales~Sum_NA_Sales,
             data=just_sales)

# View the model.
model1


# View more outputs for the model - the full regression table.
summary(model1)
 
# NA_Sales is a highly significant value, explaining 87.41% of the variability



## 2b) Create a plot (simple linear regression)
# Basic visualisation.

# View residuals on a plot.
plot(model1$residuals)


# Plot the relationship with base R graphics.
plot(just_sales$Sum_NA_Sales, just_sales$Sum_Global_Sales)


# Add line-of-best-fit.
abline(coefficients(model1))


###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
just_numeric <- select(turtle_sales, -Product, -Platform, -Genre, -Publisher)

cor(just_numeric)

# install library
library(ggcorrplot)

# Use the corPlot() function to visualize the correlations.
corPlot(just_numeric, cex=2)


# Multiple linear regression model.
# Create a new object and specify the lm function and the variables. 
# I'll use the sum of sales by product which have the highest positive correlations
# with the global sales.
modela = lm(Sum_Global_Sales~Sum_NA_Sales+Sum_EU_Sales, data=just_sales)

# Print the summary statistics.
summary(modela)


# The model seems very strong as the Adjust R-squared is 0.9685 and residual
# error of 1.112 which is a small value.


###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.
sales_test <- subset(just_sales, Sum_NA_Sales %in% c(34.02, 3.93, 2.73, 2.26, 22.08)
                     & Sum_EU_Sales %in% c(23.80, 1.56, 0.65, 0.97, 0.52))

# View the data
sales_test

# Create a new object and specify the predict function.
predictTest = predict(modela, newdata=sales_test,
                      interval='confidence')

# Print the object.
predictTest 


###############################################################################

# 5. Observations and insights
# Your observations and insights here...

# To verify the accuracy, we compare the output of the predict() function with
# the actual values we see in the sale_test output. These are relatively close.
# The first predicted value is 71.468572; the actual sale for the first
# data point is 67.8.
# The second predicted value is 26.431567; the actual sale for the second data
# point is 23.2.
# 
# The data set consisted of 352 rows and 3 numeric variables.
# The correlation plot indicated that NA_Sales and EU_Sales had a strong
# positive correlation.
# 
# Based on the correlation plot and accuracy of models in this case study,
# it seems that we can use multiple linear regression to predict the Global Sales
# based on European and North American Sales.
# 
# Additional feature could potentially improve the model's predictive power like
# critic score or user rating which can drive sales, social media metrics like
# number of mention of a certain produce, advertising and promotion metrics such as
# spending in marketing or number of promotional events.
# We also need to be be aware of the limitations of your model, such as its
# inability to capture unforeseen market trends or changes in consumer behavior.

###############################################################################
###############################################################################




