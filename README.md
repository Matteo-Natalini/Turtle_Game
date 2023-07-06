# DA301_Assignment

### Data cleaning and exploration in Python

- The data set containing customers reviews has been imported and sense checked. No missing values found.
- The dataframe contains 2000 entries.
- Redundant columns have been removed ('language' and 'platfomr').


### - how customers accumulate loyalty points (Week 1)

Possible linear relationships between loyalty points and age, remuneration, and spending scores were evaluated using linear regression and the `statsmodels` functions. The aim was to determine whether these variables could be used to predict loyalty points. 

The strongest correlation with the loyalty point dependent variable was found when assigning the spending score as the independent variable. It is possible that the reason for this is that both metrics rely on purchase behaviour. Loyalty points are determined by the point value of the purchase, while the spending score is assigned to customers based on their spending nature and behavior as determined by Turtle Games. The R-squared value for this regression is 0.452, indicating that 45% of the observed variation can be explained by the inputs. The F-statistic of 1648 and the extremely small p-value of 2.92e-263 provide strong evidence against the null hypothesis that all regression coefficients are equal to zero. The coefficient for the independent variable x is estimated at 33.0617, with a standard error of 0.814. The t-value is 40.595, indicating that the coefficient for x is statistically significant at the 0.05 level. The 95% confidence interval for x ranges from 31.464 to 34.659. The scatterplot indicates a positive correlation between spending and loyalty points that weakens beyond a score of 60. A similar scenario is observed for remuneration, with a statistically significant linear relationship between the two variables for remuneration below £60,000.

In contrast, the R-squared value for age and loyalty points suggests that only a small proportion of the variance in the dependent variable is explained by the independent variable. The F-statistic of 3.606 and the p-value of 0.0577 indicate weak evidence against the null hypothesis that all regression coefficients are equal to zero. The coefficient for the independent variable x is estimated at -4.0128 with a standard error of 2.113. The t-value is -1.899, indicating that the coefficient for x is not statistically significant at the 0.05 level, as the p-value is greater than the significance level. The 95% confidence interval for x ranges from -8.157 to 0.131. Overall, this suggests weak evidence of a linear relationship between the dependent variable and the independent variable x and not enough evidence to reject the null hypothesis that there is no significant linear relationship between them.


### - how useful are remuneration and spending scores data (Week 2)
Since the initial scatterplot, five clusters were visible at first glance, with a clear distribution at the centre and corners of the grid. Both the Elbow and Silhouette methods confirmed this initial impression. While most of the values are in the central part of the plot in cluster 0, the values are fairly distributed in the other four clusters in the corners. 
It is possible to see that the group of remuneration classes under 30k and over 60k are almost equally split into two clusters. One half has a higher spending score than the average, while the other half has a lower spending score than the average. It is necessary to include more variables to understand the behaviour behind the accumulation of spending scores.



### - can customer reviews be used in marketing campaigns (Week 3)

As part of our marketing analysis, we have examined customer reviews and their corresponding summaries. Using NLP, we have gained valuable insights that can inform future campaigns. To ensure accurate frequency counts, we kept duplicate reviews but dropped duplicates in the summary column as they typically lacked specific information beyond a positive rating (e.g. “5 stars”).
There is another reason why duplicates are not dropped in both columns. Most of the duplicates in the summary column are related to the star rating, but the review section usually contains more useful information. By removing such reviews, we risk losing valuable information about the product's sentiment.
To eliminate irrelevant words, we added "game" to our stop-word list, considering this word appeared in almost every review due to the nature of the product being reviewed. Our analysis revealed that the top 15 most frequently used words were mostly neutral or positive, with no negative words appearing on the list. While these words did not offer significant insights, they did confirm a positive sentiment among reviewers.
The polarity score histogram of the reviews showed a positive skew, indicating that the majority of comments had a positive sentiment. Similarly, the summary column was mostly positive, but with a noticeable peak in neutral comments and a spread of negative comments up to the highest polarity score.
It is important to note that the first word identified as negative by the model is "anger." However, upon further review of the associated reviews, it seems that this actually refers to a popular game about ‘anger’, which has received positive reviews. It would be advantageous to delve deeper into this matter to differentiate the various contexts in which the word is used. It is possible that it is also utilized in expressions of frustration in certain reviews.
After analyzing the most commonly used words and their polarity scores, we have identified some noteworthy features that could be utilized in future marketing campaigns. It appears that the words 'cards', 'tiles', and 'book' are frequently used in positive reviews, indicating that they may be the items that generate the most engagement. Many reviews mention the use of these toys in child therapy, with some even being recommended by therapists. While there are both positive and negative reviews, this is a frequent topic that deserves attention, particularly in targeting therapists and medical clinics. 
One common negative theme is that children may have trouble understanding the game or find it too complicated. It is recommended to review the suggested age range for the game, perhaps increasing it accordingly. 

