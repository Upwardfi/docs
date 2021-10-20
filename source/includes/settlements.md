# Settlements

## Check product's settlements

```shell
curl -X GET http://api.highline.co/products/d5165d5168-61s3.../settlements \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[
  {
    "id": "25de3...",
    "client_id": "bd545...",
    "client": {},
    "product_id": "bd545...",
    "product":{},
    "bill_payments": [{}],
    "payment_order_id": "5465sd1fsd516...",
    "status": "completed",
    "total_amount": 50000,
    "completed_at": 1633824000,
    "created_at": 1633824000,
    "updated_at": 1634428800
  }
]
```

This API checks if user's employer is supported through Highline and will return success or failure based on eligibility.

`GET http://api.highline.co/products/{id}/settlements`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | param | Product ID
`status` *optional* | string | query | Status of settlement
`start_date` *optional* | string | query | Settlement created at since date
`end_date` *optional* | string | query | Settlement created at until date

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Settlement ID
`client_id` | string | Company ID
`client` | json | Company structure
`product_id` | string | Product ID
`product` | json | Product structure
`bill_payments` | array | Bill payments structure
`payment_order_id` | string | Order ID
`status` | string | Settlement status ("pending" "sent" "completed" "cancelled")
`total_amount` | int | Total amount (in cents)
`completed_at` | timestamp | Date of completion (if completed)
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update