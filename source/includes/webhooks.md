# Webhooks

Highline’s daily operations involve a number of asynchronous events regarding payments, data, and other subsets of our product. These can range from updating the status of a customer’s employment to settling funds with clients.

In order to maintain clarity and consistency with our partners, Highline uses webhooks to communicate key events regarding the bill payment process. This allows clients to receive notifications anytime a relevant event occurs.



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
    "data": {
      "bill_payment_id": "da345...",
      "metadata": {
        "product_id": "24de3..."
      },
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
    "data": {
      "settlement_id": "da345...",
      "metadata": {
        "product_id": "24de3..."
      },
    }
  }
```


### Settlements Events


Event | Description
------ | ----------
"created" | The day when a settlement process is initiated.
"sent" | The day when a settlement is sent by Highline.
"completed" | The day when a settlement has been delivered successfully.
"canceled" | The day when a settlement has been canceled

### Pay Allocations

> <div class="code-block-title">Example Payload</div>

```json
  {
    "topic": "pay_allocations",
    "event": "sent",
    "data": {
      "pay_allocation_id": "da345...",
      "metadata": {
        "product_id": "24de3..."
      },
    }
  }
```


### Pay Allocations Events

Event | Description
------ | ----------
"active" | Payment allocation is active
"pending" | Payment allocation is pending 


### Enrollments

> <div class="code-block-title">Example Payload</div>

```json
  {
    "topic": "enrollments",
    "event": "active",
    "data": {
      "pay_allocation_id": "da345...",
      "metadata": {
        "product_id": "24de3..."
      },
    }
  }
```


### Enrollments Events

Event | Description
------ | ----------
"active" | Enrollment is active
"completed" | Enrollment is completed and no longer being processed by highline
