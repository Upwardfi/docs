# Pay histories

## Get User's Pay histories

```shell
curl -X GET http://api.highline.co/users/6516515-651.../payout_histories \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "ca71927a-c5...",
  "user_id": "ae16efec-d1...",
  "user": {},
  "employment_id": "d6b10b60-55...",
  "employment": {},
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

`GET http://api.highline.co/users/{id}/payout_histories`

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
`user` | json | User structure
`employment_id` | string | Employment ID
`employment` | json | Employment structure
`gross_amount` | int | Gross Amount (in cents)
`net_amount` | int | Net Amount (in cents)
`currency` | string | Currency
`paid_date` | timestamp | Paid date (when paid)
`start_date` | timestamp | Start date
`end_date` | timestamp | End date
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update