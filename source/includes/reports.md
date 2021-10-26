# Reports
Every client of Highline is obligated to participate in a daily exchange of data between themselves and Highline. This is a report that allows Highline to monitor the status of all active bill payments, and keep our respective ledgers in sync. If there’s a change or inconsistency from one day to the next, the daily client report will help Highline see this change in real-time and act accordingly.

We offer two ways to exchange this data. Our recommended solution is setting up an automatic exchange using the API’s below. Alternatively, we offer a manual report upload from the client portal.

## Add product's daily data report

```shell
curl -X POST https://api.highline.co/products/d5165d5168-61s3.../reports \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: multipart/form-data"
  -d $'dailyReport:file'
```

> Response

```json
{
  "success": true
}
```

This API add a daily data report for the provided product id.

`POST https://api.highline.co/products/{id}/reports`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | param | Product ID
`dailyReport` *required* | string | file | File containing the report






## Check product's reports

```shell
curl -X GET https://api.highline.co/products/d5165d5168-61s3.../reports \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "25de3...",
  "product_id": "bd545...",
  "file_name": "updated_file",
  "clienet_report_entries": [{
    "client_user_id": "bd545...",
    "enrollment_id": "bd545...",
    "enrollment_current_balance": 12000,
    "next_payment_due_amount": 2000,
    "bill_payment_recurring_amount": 2000
  }],
  "status": "new",
  "created_at": 1633824000,
  "updated_at": 1634428800
}]
```

This API checks the product's daily data reports.

`GET https://api.highline.co/products/{id}/reports`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | param | Product ID

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Report ID
`product_id` | string | Product ID
`file_name` | string | File name
`client_report_entries` | array | Collection of report entries
`status` | string | Report status ("new" "error" "processed")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
