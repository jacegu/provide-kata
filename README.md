# Provide Kata

You work for a subscription-based SAAS (Software As A Service) company.

The company has been consistently growing for the past few years and is now
making a very healthy profit. Owners have decided to change the legal entity
of the company, which will trigger changes in how the company operates.

Part of these changes include a new accounting system that must be implemented.
This new software will track all transactions involving cash or credit in a
very specific way to ease accountant's job when filing tax reports with the
Government.


## Your job

Your team has been hired to help developing the new accounting system. The
basics of the system have already been implemented, so you have some of the
work done already.

Your first task will be adding support for a transaction type called _Provide_.


## Current status of the system

The new accounting system is already under development.

### Data

Here is some relevant data that the SAAS already managed and the new data the
accounting system is managing.

#### Subscriptions

Subscriptions include the following information:
- `id`: Unique identifier for the subscription.
- `customer_id`: The customer the subscription corresponds to (only 1 subscription per customer).
- `plan_id`: The plan the customer is subscribed to.
- `state`: The state of the subscription. One of `trialing`, `active`, `past_due` or `canceled`.

#### Plans

Plans include the following information:
- `id`: Unique identifier for the plan.
- `name`: The name of the plan. Existing plans are: _Silver_, _Gold_, _Silver Yearly_, _Gold Yearly_.
- `billing_period`: Either `monthly` or `yearly`.

#### Transactions

Transactions include the following information:
- `customer_id`: The customer the transaction corresponds to.
- `amount`: The amount of the transaction.
- `timestamp`: The time when the transaction took place.
- `identifier`: Unique identifier for the transaction. When a transaction is
  composed by several sub-transactions (a.k.a. _mixed transaction_), all of them
  will share the same `transaction_id`.
- `seq`: The number of the transaction in a mixed transaction.
- `max`: The total number of transactions in a mixed transaction.
- `type`: The type of operation the transaction corresponds to. There are 24
  different types of transactions identified by the accountants.
  Here are some of them:


  | type | name                        | explanation |
  |------|-----------------------------|-------------|
  | 1    | subscription_monthly_cash   | A subscription to a monthly plan paid with cash |
  | 2    | subscription_monthly_credit | A subscription to a monthly plan paid with credit |
  | 3    | subscription_monthly_mixed  | A subscription to a monthly plan paid with cash and credit |
  | 4    | plan_change_monthly_cash    | A plan change to a monthly plan paid with cash |
  | 5    | plan_change_monthly_credit  | A plan change to a monthly plan paid with credit |
  | 6    | plan_change_monthly_mixed   | A plan change to a monthly plan paid with cash and credit |
  | 7    | plan_change_yearly_cash     | A plan change to a yearly plan paid with cash |
  | 8    | plan_change_yearly_credit   | A plan change to a yearly plan paid with credit |
  | 9    | plan_change_yearly_mixed    | A plan change to a yearly plan paid with cash and credit |
  | 10   | subscription_yearly_cash    | A subscription to a yearly plan paid with cash |
  | 11   | subscription_yearly_credit  | A subscription to a yearly plan paid with credit |
  | 12   | subscription_yearly_mixed   | A subscription to a yearly plan paid with cash and credit |
  | 13   | provide                     | Monthly booked revenue for subscriptions to yearly plans (*explanation*) |
  | 14   | unsubscribe                 | May trigger refunds or book revenue(*explanation*) |


##### Provide Transaction

> Explanation

###### Example

| customer_id | amount | timestamp (*as date*) | identifier | seq | max | type |
|-------------|--------|-----------------------|------------|-----|-----|------|
| 1011        | 144    | 2018-01-25            | A1         | 1   | 3   | 12   |
| 1011        | 100    | 2018-01-25            | A1         | 2   | 3   | 10   |
| 1011        | 44     | 2018-01-25            | A1         | 3   | 3   | 11   |
| 1011        | 12     | 2018-01-25            | A15        | 1   | 1   | 13   |
| 1011        | 12     | 2018-02-25            | B8754      | 1   | 1   | 13   |
| 1011        | 12     | 2018-03-25            | D4701      | 1   | 1   | 13   |
| 1011        | 12     | 2018-04-25            | A17010     | 1   | 1   | 13   |
| ...         | ...    | ...                   | ...        | ... | ... | ...  |
| 1011        | 12     | 2018-11-25            | R9002      | 1   | 1   | 13   |
| 1011        | 12     | 2018-12-25            | Y0407      | 1   | 1   | 13   |



### Entry points

The accounting system behaviour is hold in the namespace `Accounting`. 

Currently the following behaviour-entry-point exists: `Accounting#record_subscription_yearly`.
It will record the transaction types 10, 11 and 12.

You will have add the necessary behaviour to the system to support transaction type 13.


## Work to be done

1. In groups, define the solution in a diagram of your choice.
1. Same groups, verify that the system supports plan changes and cancelations.
