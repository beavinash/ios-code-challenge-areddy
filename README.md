# ios-code-challenge

Rune Labs coding challenge for iOS engineer

## Summary

You are building an iOS app to help dental hygiene enthusiasts visualize a paginated dataset using a line chart. The dataset represents the survey of number of people brushing their teeth at different points in time. Your app will load data from a paginated REST "API".

The API has a single endpoint `https://raw.githubusercontent.com/rune-labs/{YOUR_REPO_NAME}/master/api/{PAGE}.json`, where: 
* `{YOUR_REPO_NAME}` is the name of this GitHub repo (i.e. `ios-code-challenge-...`). 
* `{PAGE}` is the 1-indexed page number (`1` for first page, `2` for second page, and so on).

Each page returns a JSON array of **up to 10,000** objects, representing the chronologically ordered data points within the given range. Page 1 contains the first 10K data points, page 2 contains points 10K through 20K, and so on.

When you request a page whose range is past the dataset's total cardinality, you will get a 404. Your code should not assume any specific number of points (and therefore specific  number of pages) are available in the dataset. Today the endpoint may return 3 pages of data, tomorrow it may be 10 or 0.

Each data point has the following shape:

* A ‘t’ property which contains the UNIX timestamp in seconds, of when the statistic was sampled.
* A ‘y’ property which contains the value at that point in time (estimated number of people brushing their teeth).

*NOTE: Do not simply include a copy of this data in your iOS app bundle! It should be loaded dynamically over HTTP.*

## Requirements

* Display a line chart visualization to represent a single "page" of data.
    * Decorate and label your chart as you see fit to make it easy to read (hint: turn the UNIX timestamps into readable date/time labels). Your soluton won't be evaluated on graphic design, but it should be usable.
* The user should be able to switch between pages with a Next and Previous buttons (can be icons).
* When you run out of pages (of data), indicate this to the user in whatever visual way makes sense in your design.
* Write unit tests for your app. We should be able to run these unit tests with no network connectivity.
    * Include tests with mock data testing various edge cases, assuming nothing about the actual shape of the data (even though you have access via our pages API).
* OPTIONAL BONUS: Allow the user to specify custom page size that is different than the actual size of the API response pages.
    * For example, if user selects a page size of 5000, data for the first two pages displayed in your app will come from the first and second half of API result page 1. If they select 7500, then the second page will contain the last 2500 from result page 1 and first 5000 from page 2, and so on. 

## Guidelines

Your solution will be evaluated on

1. Code organization and readability
2. Test coverage
3. Appropriate use of iOS libraries and SDKs
4. Correctness of data representation (you are visualizing the right data, without distortion).

Please write your code in Swift. Feel free to use any third party libraries.
Provide any extra instructions you think necessary for us to run your code.

## Submission

Please fork this repo, and submit a GitHub Pull Request back to it when done. You are encouraged to commit frequently at reasonable checkpoints (based on your judgement).

Please email miro@runelabs.io when you are done.
