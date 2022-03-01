# Webhooks

Highline’s daily operations involve a number of asynchronous events regarding payments, data, and other subsets of our product. These can range from updating the status of a customer’s employment to settling funds with clients. 

In order to maintain clarity and consistency with our partners, Highline uses webhooks to communicate key events regarding the bill payment process. This allows clients to receive notifications anytime a relevant event is impacted by our operations.

## Setup
Custom webhook endpoints can be created from the [company settings page](https://app.highline.co/profile). Navigate to the client portal and create a new webhook and start receiving following webhook events

## Bill Payment Lifecycle
The following events relate to the entirety of Highline’s bill payment lifecycle. 


## Topics

### Bill Payments

> <div class="code-block-title">Example Payload</div>

```json
  {
    "topic": "bill_payments",
    "event": "paid",
    "metadata": {
      "product_id": "24de3..."
    },
    "data": {
      "bill_payment_id": "da345..."
    }
  }
```


### Bill Payment Events


Event | Description
------ | ----------
"paid" | A bill was paid successfully
"created" | A new bill payment has been created
"payments_initiated" | Settlement has been initiated for a bill payment
"needs_attention" | An expected payment allocation was not received by Highline, resulting in a less-than-expected amount collected in this bill payment. 
"excess_funds_transfer_initiated" | Excess funds have been returned to the member
"insufficient_funds_transfer_initiated" | Transfer of balance for insufficient funds have been initiated

### Settlements

> <div class="code-block-title">Example Payload</div>

```json
  {
    "topic": "settlements",
    "event": "pending",
    "metadata": {
      "product_id": "24de3..."
    },
    "data": {
      "settlement_id": "da345..."
    }
  }
```


### Settlements Events


Event | Description
------ | ----------
"created" | The day’s settlement is created and ready to be sent
"sent" | The day’s settlement has been sent by Highline
"completed" | The day’s settlement has been delivered successfully 
"canceled" | The day’s settlement has been canceled

### Pay Allocations

> <div class="code-block-title">Example Payload</div>

```json
  {
    "topic": "pay_allocations",
    "event": "sent",
    "metadata": {
      "product_id": "24de3..."
    },
    "data": {
      "pay_allocation_id": "da345..."
    }
  }
```


### Pay Allocations Events

Event | Description
------ | ----------
"active" | Payment allocation is active
"pending" | Payment allocation is pending 
