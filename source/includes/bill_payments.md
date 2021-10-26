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
      "company_id": "6335861a-f23...",
      "company": {
        "id": "6335861a-f23...",
        "name": "Mrs. Maryam Swaniawski",
        "legal_entity": "Ms. Susie Lubowitz",
        "tax_id": "8a6465c0-f32...",
        "phone": "104-769-1538",
        "email": "XabJCOW@ocpDoBb.info",
        "logo_url": "https://logo.clearbit.com/highline.co",
        "created_at": 1631304119,
        "updated_at": 1631304119
      },
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

 As explained previously, Highline pulls a small allocation from each paycheck automatically to dedicated bill payments at the top of the earning funnel. The following API’s will help you get information on a user’s active bill payments & history.

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
`enrollment` | json | Enrollment structure
`transactions` | array | Collection of transactions structure
`employer_name` | string | Name of employer
`logo_url` | string | Path of logo URL
`loan_description` | string | Description of the Loan
`amount_paid` | int | Value paid (in cents)
`amount_due` | int | Value to be paid (in cents)
`ForecastedDueAmount` | int | Forecasted Value to be paid (in cents)
`ForecastedDueDate` | timestamp | Forecasted date to be paid (in cents)
`status` | string | Status of the bill payment ("paid" "pending" "cancelled" "new" "on_track" "risk_of_error" "ready_to_pay" "initiated" "needs_attention")
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
      "company_id": "6335861a-f23...",
      "company": {
        "id": "6335861a-f23...",
        "name": "Mrs. Maryam Swaniawski",
        "legal_entity": "Ms. Susie Lubowitz",
        "tax_id": "8a6465c0-f32...",
        "phone": "104-769-1538",
        "email": "XabJCOW@ocpDoBb.info",
        "logo_url": "https://logo.clearbit.com/highline.co",
        "created_at": 1631304119,
        "updated_at": 1631304119
      },
      "type": "personal_loan",
      "name": "Product 1",
      "description": "Consequatur voluptatem au...",
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
    "account_reference_number": "33333",
    "days_until_expires": 30,
    "required_employment_start_date": 1460845141,
    "required_gross_income": 35000,
    "required_net_income": 25000,
    "fully_synced": false,
    "status": "pending",
    "created_at": 1631304121,
    "updated_at": 1631304121
  },
  "employer_name": "Christian",
  "logo_url": "https://cdn-icon....png",
  "loan_description": "Consequatur accusantium ...",
  "amount_paid": 100,
  "amount_due": 100,
  "status": "paid",
  "settlement_id": "25de3...",
  "settlement": {
    "id": "25de3...",
    "client_id": "bd545...",
    "client": {},
    "product_id": "bd545...",
    "payment_order_id": "5465sd1fsd516...",
    "status": "completed",
    "total_amount": 50000,
    "completed_at": 1633824000,
    "created_at": 1633824000,
    "updated_at": 1634428800
  },
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
`enrollment` | json | Enrollment structure
`employer_name` | string | Name of employer
`logo_url` | string | Path of logo URL
`loan_description` | string | Description of the Loan
`amount_paid` | int | Value paid (in cents)
`amount_due` | int | Value to be paid (in cents)
`ForecastedDueAmount` | int | Forecasted Value to be paid (in cents)
`ForecastedDueDate` | timestamp | Forecasted date to be paid (in cents)
`status` | string | Status of the bill payment ("paid" "pending" "cancelled" "new" "on_track" "risk_of_error" "ready_to_pay" "initiated" "needs_attention")
`settlement_id` | string | Stettlement ID
`settlement` | json | Stettlement Structure
`paid_at` | timestamp | Date of payment (if paid)
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
  "amount_expected": 50000,
  "amount_paid": 0,
  "paid": false,
  "status": "pending",
  "type": "",
  "payment_order_id": "65s1f6s...",
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
`amount_expected` | int | Amount expected (in cents)
`amount_paid` | int | Amount expected (in cents)
`paid` | bool | Indication if this transaction is paid
`status` | string | Transaction status ("completed" "pending" "cancelled")
`type` | string | Transaction type ("ach" "credit_card" "debit_card")
`payment_order_id` | string | Orde ID
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
