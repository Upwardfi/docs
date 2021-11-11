# Pay histories

## Get User's Pay histories

```shell
curl -X GET https://api.highline.co/users/6516515-651.../pay_histories \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
[{
  "id": "ca71927a-c5...",
  "user_id": "ae16efec-d1...",
  "employment_id": "d6b10b60-55...",
  "employment": {
    "id": "d6b10b60-55...",
    "user_id": "ae16efec-d1...",
    "employer_id": "d5b6c756-f9...",
    "employer": {
      "id": "d5b6c756-f9...",
      "name": "Kroger"
    },
    "job_title": "1635 - Helpline Agent",
    "start_date": 1393924766,
    "end_date": 1636225502,
    "base_pay": 25599,
    "base_annual_income": 25599,
    "pay_cycle": "weekly",
    "pay_currency": "USD",
    "type": "full-time",
    "status": "active",
    "created_at": 1633633503,
    "updated_at": 1633633503
  },
  "gross_amount": 50000,
  "net_amount": 10000,
  "currency": "usd",
  "paid_date": 1633633510,
  "start_date": 1633633510,
  "end_date": 1633634510,
  "created_at": 1633633510,
  "updated_at": 1633633510
}]
```

This API endpoint returns the user's Pay histories, based on the provided user id.

`GET https://api.highline.co/users/{id}/pay_histories`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID
`start_date` *optional* | string | query | Paid date since date
`end_date` *optional* | string | query | Paid date until date
`order` *optional* | string | query | Order expected ("asc" or "desc") of Paid date

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Payout Allocation ID
`user_id` | string | User ID
`employment_id` | string | Employment ID
`employment` | json | Employment object
`gross_amount` | int | Gross Amount (in cents)
`net_amount` | int | Net Amount (in cents)
`currency` | string | Currency
`paid_date` | timestamp | Paid date (when paid)
`start_date` | timestamp | Pay period start date
`end_date` | timestamp | Pay period end date
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
