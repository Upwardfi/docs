# Settlements

A settlement refers to the transfer of funds between Highline and clients. This happens whenever a bill payment is due, and will be reflected in this API and our daily settlement file. The daily settlement file is available by 4pm ET.

## Check product's settlements

```shell
curl -X GET https://api.highline.co/products/d5165d5168-61s3.../settlements \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
[
  {
    "id": "25de3...",
    "client_id": "bd545...",
    "product_id": "bd545...",
    "status": "completed",
    "total_amount": 50000,
    "bill_payments": [{"bill_payment_object"}],
    "completed_at": 1633824000,
    "created_at": 1633824000,
    "updated_at": 1634428800
  }
]
```

This API return the settlements, based on the provided product id.

`GET https://api.highline.co/products/{id}/settlements`

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
`product_id` | string | Product ID
`status` | string | Settlement status ("pending" "sent" "completed" "canceled")
`total_amount` | int | Total amount (in cents)
`completed_at` | timestamp | Date of completion (if completed)
`bill_payments` | Array | List of bill payment objects are the paid in this settlement file
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
