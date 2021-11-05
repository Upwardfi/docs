# Bill Payments

## Get User's Bill Payments

```shell
curl -X GET https://api.highline.co/users/ae16efec-d1.../bill_payments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "e87f74be-c46...",
  "enrollment_id": "3347c40d-2f9...",
  "enrollment": {
    "id": "3347c40d-2f9...",
    "product_id": "22621f3b-563...",
    "product": {
      "id": "22621f3b-563...",
      "type": "personal_loan",
      "name": "Product 1",
      "validate_direct_deposits": true,
      "validate_payout_allocation": true,
      "validate_employment_active": true,
      "max_payment_to_income_ratio": 0,
      "created_at": 1631304120,
      "updated_at": 1631304120
    },
    "payment_amount": 500,
    "loan_amount": 200000,
    "loan_term": 24,
    "payment_frequency": "monthly",
    "first_payment_date": 1638310741,
    "application_reference_number": "12234",
    "days_until_expires": 30,
    "status": "pending",
    "created_at": 1631304121,
    "updated_at": 1631304121
  },
  "amount_paid": 100,
  "amount_due": 100,
  "status": "paid",
  "settlement_id": "e87f74be-c46...",
  "paid_at": 1631282525,
  "created_at": 1631304125,
  "updated_at": 1631304125
}]
```

 As explained previously, Highline pulls a small allocation from each paycheck automatically to dedicated bill payments at the top of the earning funnel. The following API’s will help you get information on your users active bill payments & history with Highline.

### HTTP Request

`GET https://api.highline.co/users/{id}/bill_payments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID
`product_id` *optional* | string | query | Product ID
`status` *optional* | string | query | Status of bill payment
`start_date` *optional* | string | query | Paid at since date
`end_date` *optional* | string | query | Paid at until date

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Bill Payment ID
`enrollment_id` | string | Enrollment ID
`enrollment` | json | Enrollment object
`logo_url` | string | Path of logo URL
`amount_paid` | int | Value paid (in cents)
`amount_due` | int | Value to be paid (in cents)
`status` | string | Status of the bill payment ("paid" "pending" "canceled" "new" "on_track" "ready_to_pay" "initiated")
`settlement_id` | string | Stettlement ID
`paid_at` | timestamp | Date of payment (if paid)
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update




## Get Enrollment's Bill Payments

```shell
curl -X GET https://api.highline.co/enrollments/ae16efec-d1.../bill_payments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "e87f74be-c46...",
  "enrollment_id": "3347c40d-2f9...",
  "enrollment": {
    "id": "3347c40d-2f9...",
    "product_id": "22621f3b-563...",
    "product": {
      "id": "22621f3b-563...",
      "type": "personal_loan",
      "name": "Product 1",
    },
    "payment_amount": 500,
    "loan_amount": 200000
  },
  "amount_paid": 100,
  "amount_due": 100,
  "status": "paid",
  "settlement_id": "25de3...",
  "paid_at": 1631282525,
  "created_at": 1631304125,
  "updated_at": 1631304125
}]
```

This API endpoint returns the enrollment's bill payments details based on the provided enrollment id.

### HTTP Request

`GET https://api.highline.co/enrollments/{id}/bill_payments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID
`product_id` *optional* | string | query | Product ID
`status` *optional* | string | query | Status of bill payment
`start_date` *optional* | string | query | Forecasted due date since date
`end_date` *optional* | string | query | Forecasted due date until date
`order` *optional* | string | query | Order expected ("asc" or "desc") of Forecasted due date

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Bill Payment ID
`enrollment_id` | string | Enrollment ID
`enrollment` | json | Enrollment object
`amount_paid` | int | Value paid (in cents)
`amount_due` | int | Value to be paid (in cents)
`status` | string | Status of the bill payment ("paid" "partially_paid" "pending" "canceled" "new" "on_track" "ready_to_pay" "initiated")
`settlement_id` | string | Settlement ID
`paid_at` | timestamp | Date on which the bill is fully paid
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update











## Get Bill Payment's transactions

```shell
curl -X GET https://api.highline.co/bill_payments/ae16efec-d1.../transactions \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "ef8b53a0-bfd...",
  "bill_payment_id": "e87f74be-c46...",
  "amount_paid": 0,
  "paid": false,
  "status": "pending",
  "type": "",
  "created_at": 1631304126,
  "updated_at": 1631304126
}]
```

This API endpoint returns the bill payments's transactions details based on the provided bill payment id.

### HTTP Request

`GET https://api.highline.co/bill_payments/{id}/transactions`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | Bill Payment ID

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Transaction ID
`bill_payment_id` | string | Bill payment ID
`amount_paid` | int | Amount expected (in cents)
`paid` | bool | Indication if this transaction is paid
`status` | string | Transaction status ("completed" "pending" "canceled")
`type` | string | Transaction type ("ach" "credit_card" "debit_card")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
