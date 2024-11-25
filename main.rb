Problem Statement:
You have a portfolio of stocks, where each stock has a specific dollar amount invested. Over time, the portfolio values may shift, causing the distribution to differ
from a desired allocation. Your goal is to "rebalance" the portfolio to match a target distribution by creating trade instructions for each stock adjustment.
Instructions
Write a Ruby class called Rebalance, which:
Accepts two parameters: current_portfolio and desired_portfolio.
Calculates the difference between the current portfolio distribution and the target distribution.
Produces a list of trade instructions to rebalance the portfolio as close as possible to the target.
2. Trade instructions should be structured as a hash with the format:
{ FROM: :STOCK_A, TO: :STOCK_B, AMOUNT: X }
where:
FROM indicates the stock to sell.
TO indicates the stock to buy.
AMOUNT is the dollar amount to transfer.
3. Ensure that your code handles cases where the current portfolio and desired portfolio values are not equal, returning an appropriate message in such cases.
4. Your solution should aim to minimize the number of trades made
Example
current_portfolio = { WMT: 250, TSLA: 550 }
desired_portfolio = { WMT: 400, TSLA: 400 }

expected output :
 
[{ FROM: :TSLA, TO: :WMT, AMOUNT: 150 }]