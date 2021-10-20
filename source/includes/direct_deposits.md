# Direct Deposits

## Get User's direct deposits

```shell
curl -X GET http://api.highline.co/users/6516515-651.../payout_allocations \
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
  "bank_account_id": "4fb1c5dd-5d...",
  "bank_account": {},
  "status": "active",
  "created_at": 1633633510,
  "updated_at": 1633633510
}]
```

This API endpoint returns the user's payout allocations, that represents direct deposits, based on the provided user id.

`GET http://api.highline.co/users/{id}/payout_allocations`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Payout Allocation ID
`user_id` | string | User ID
`user` | json | User structure
`employment_id` | string | Employment ID
`employment` | json | Employment structure
`bank_account_id` | string | Bank account ID
`bank_account` | json | Bank account structure
`status` | string | Status of payout allocation ("active" "pending")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update