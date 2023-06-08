# DA301_Assignment

## Week 1 assignment: Linear regression using Python

### Data cleaning and exploration

- The data set containing customers reviews has been imported and sense checked. No missing values found.
- The dataframe contains 2000 entries.
- Redundant columns have been removed ('language' and 'platfomr').


### Linear Regression 

Possible linear relationships between loyalty points and age, remuneration, and spending scores were evaluated using linear regression and the `statsmodels` functions. The aim was to determine whether these variables could be used to predict loyalty points. 

The strongest correlation with the loyalty point dependent variable was found when assigning the spending score as the independent variable. It is possible that the reason for this is because both metrics rely on purchase behavior. Loyalty points are determined by the point value of the purchase, while the spending score is assigned to customers based on their spending nature and behavior as determined by Turtle Games. The R-squared value for this regression is 0.452, indicating that 45% of the observed variation can be explained by the inputs. The F-statistic of 1648 and the extremely small p-value of 2.92e-263 provide strong evidence against the null hypothesis that all regression coefficients are equal to zero. The coefficient for the independent variable x is estimated at 33.0617, with a standard error of 0.814. The t-value is 40.595, indicating that the coefficient for x is statistically significant at the 0.05 level. The 95% confidence interval for x ranges from 31.464 to 34.659. The scatterplot indicates a positive correlation between spending and loyalty points that weakens beyond a score of 60. A similar scenario is observed for remuneration, with a statistically significant linear relationship between the two variables for remuneration below £60,000.

In contrast, the R-squared value for age and loyalty points suggests that only a small proportion of the variance in the dependent variable is explained by the independent variable. The F-statistic of 3.606 and the p-value of 0.0577 indicate weak evidence against the null hypothesis that all regression coefficients are equal to zero. The coefficient for the independent variable x is estimated at -4.0128 with a standard error of 2.113. The t-value is -1.899, indicating that the coefficient for x is not statistically significant at the 0.05 level, as the p-value is greater than the significance level. The 95% confidence interval for x ranges from -8.157 to 0.131. Overall, this suggests weak evidence of a linear relationship between the dependent variable and the independent variable x and not enough evidence to reject the null hypothesis that there is no significant linear relationship between them.


### Make predictions with clustering.
Since the initial scatterplot, five clusters were visible at first glance, with a clear distribution at the centre and corners of the grid. Both the Elbow and Silhouette methods confirmed this initial impression. While most of the values are in the central part of the plot in cluster 0, the values are fairly distributed in the other four clusters in the corners. 



