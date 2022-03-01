# Reports
Every client of Highline is obligated to participate in a daily exchange of data between themselves and Highline. This is a report that allows Highline to ensure we are only pushing payments when needed, we flag cases a bill will not be able to be paid and we ensure payments have been posted accurately. If there’s a change or inconsistency from one day to the next, the daily client report will help Highline see this change in real-time and act accordingly.

We offer two ways to exchange this data. Our recommended solution is setting up an automatic exchange using the API’s below. Alternatively, we offer a manual report upload and download from the client portal.

## Add product's daily data report

> <div class="code-block-title">Add Product's Daily Data Report Request</div>

```shell
curl -X POST https://api.highline.co/products/d5165d5168-61s3.../reports \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: multipart/form-data"
  -d $'dailyReport:file'
```

> <div class="code-block-title">Response</div>

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

The dailyReport must be in CSV or JSON format.



## Check product's reports

> <div class="code-block-title">Check Product's Reports Request</div>

```shell
curl -X GET https://api.highline.co/products/d5165d5168-61s3.../reports \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
[{
  "id": "25de3...",
  "product_id": "bd545...",
  "file_name": "updated_file",
  "clienet_report_entries": [{
    "client_reference_id": "bd545...",
    "enrollment_id": "bd545...",
    "current_balance": 12000,
    "next_payment_due_amount": 2000,
    "next_payment_due_date": 1633834000,
    "recurring_payment_amount": 2000
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
`client_report_entries` | array | Collection of report entries. Each report entry corresponds to one active Highline payments account.
`status` | string | Report status ("new" "error" "processed")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

### Client report entry object

Parameter | Type | Description
--------- | ------- | -----------
`client_reference_id` | string | The application ID or account ID on your system
`client_user_account_status` | string | The account status on your system
`enrollment_id` | string | Enrollment ID
`current_balance` | string | Current balance due on the payments account
`next_payment_due_amount` | int | Next payment amount due
`next_payment_due_date` | int64 | Date the next payment is due
`recurring_payment_amount` | int | Recurring payment amount
`additional_payment_due_amount` *optional* | int | If there are one time additional payment
`last_payment_received_at` | int64 | Date the last Highline payment was received
`last_payment_amount` | int | Amount received from the last Highline payment
`current_maturity_date` | int64 | The final payment date
