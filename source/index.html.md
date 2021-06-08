---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='#'></a>
  - <a href='https://github.com/slatedocs/slate'></a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to Upward - a seamless integration to setting up automated payments directly from your platform user's income. You can inititiate enrollment by calling Upward's API endpoints and displaying the widget.

This API reference provides information on available endpoints and how to interact with it.

Upward's API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. All requests should be over SSL. All request and response bodies, including errors are encoded in JSON.

```shell
https://api.upwardfi.com
```
# API Keys

Upward authenticates your API requests using your account’s API keys. If you do not include your key when making an API request, or use one that is incorrect or outdated, Upward returns an error.

The API key should be kept confidential and only stored on your own servers. Your account’s API key can perform any API request to Upward without restriction.

Each account has a total of two keys: a key pair for test mode and live mode.

# Authentication

Authentication is done via the API key which you can find in your accounts settings endpoint. Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

Test mode secret keys have the prefix sk_test_ and live mode secret keys have the prefix sk_live_. Alternatively, you can use restricted API keys for granular permissions.

Authentication to the API is performed via HTTP Basic Auth. Provide your API key as the basic auth username value. You do not need to provide a password.

> If you need to authenticate via bearer auth (e.g., for a cross-origin request), use -H "Authorization: Bearer base64(ai_test_app_id:sk_test_8fD39MqLyjWBarjtP1zdp7bc)"

> Example Request:

```shell
curl -X GET https://api.upwardfi.com/enrollments \
  -H "Authorization: Bearer base64(ai_test_app_id:sk_test_8fD39MqLyjWBarjtP1zdp7bc)"
  ```

> All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without authentication will also fail.

```shell
# With shell, you can just pass the correct header with each request
curl -X GET http://api.upwardfi.com/enrollments \
  -H "Authorization: your_api_key"
```

# Rate limiting

Upward's API are rate limited to prevent abuse that would degrade our ability to maintain consistent API performance for all users. By default, each API key or app is rate limited at 10,000 requests per hour. If your requests are being rate limited, HTTP response code 429 will be returned with an rate_limit_exceeded error.

# Enrollments

## Check if employer is supported
This API checks if user's employer is supported through Upward and will return success or failure based on eligibility.

`GET http://api.upwardfi.com/supported_employers`

### Arguments

Parameter | Type | Description
--------- | ------- | -----------
`employer_name` *required* | string | Employer name

### Response

Parameter | Type | Description
--------- | ------- | -----------
`is_supported` | boolean | Returns true if supported and false if not. 

```shell
curl -X GET http://api.upwardfi.com/supported_employers?employer_name=Kroger \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
{
  "is_supported": "true"
}
```
## Initiate user enrollment
This API initiates user enrollment via Upward.By passing basic enrollment information Upward will return a key unique to the enrollment.

### HTTP Request

`POST http://api.upwardfi.com/enrollments`

### Request Body

Parameter | Type | Description
--------- | ------- | -----------
`payment_amount` *optional* | float | Recurring amount to be paid to you by the user
`payment_frequency` *optional* | string | Frequency interval that user will make payments
`first_payment_date` *optional* | int | Date of first payment as Unix timestamp
`application_reference_number` *optional* | string | Loan application number
`account_reference_number` *optional* | string | Your account reference number
`days_until_expires` *optional* | int | Number of days before this enrollment request expires
`required_employment_start_date` *optional* | int | start date of employment as Unix timestamp
`required_gross_income` *optional* | float | user gross income
`required_net_income` *optional* | float | user net income
`return_w2_data` *optional* | boolean | Specify true if user w2 data must be returned
`return_paystubs` *optional* | boolean | Specify true if link to user paystubs must be returned

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.


```shell
curl -X POST http://api.upwardfi.com/enrollments \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" \
  -d $'{
    "payment_amount": 200.00
  }'
```

> The above command returns JSON structured like this:

```json
{
  "id": "YtMXJzGzJcht38SCJuMhzC"
}
```

## Add users to enrollments

This API endpoint adds a user to the enrollment via Upward.By passing basic user information Upward will return a key unique to the user based on the provided enrollment.

### HTTP Request

`POST http://api.upwardfi.com/enrollments/{id}/users`

### Path parameter

Parameter | Type | Description
--------- | ------- | -----------
`id` *required* | string | Enrollment id

### Request Body

Parameter | Type | Description
--------- | ------- | -----------
`username` *required* | string | User name 
`email` *required* | string | Email id of user
`first_name` *required* |string | First Name
`last_name` *required* | string | Last Name
`ssn` *required* | string | Social Security Number
`line1` *required* | string | Line 1 Street address
`line2` *required* | string | Line 2 Street address
`city` *required* | string | City
`state` *required* | string | State
`zip5` *required* | int | Zip code
`country` *required* | string | Country
`employer` *optional* | string | User employer name
`phone_number` *optional* | string | Phone number
`date_of_birth` *optional* | int | Date of birth as Unix timestamp

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.


```shell
curl -X POST http://api.upwardfi.com/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" \
  -d $'{
    "username": "john_smith"
  }'
```

> The above command returns JSON structured like this:

```json
{
  "id": "38SCJuMhzCYtMXJzGzJcht"
}
```

## Get enrolled users

This API endpoint rerturns users that are enrolled based on the provided enrollment id.

### HTTP Request

`GET http://api.upwardfi.com/enrollments/{id}/users`

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | User id
`username` | string | User name 
`email` | string | Email id of user
`first_name` |string | First Name
`last_name` | string | Last Name
`ssn` | string | Social Security Number
`line1` | string | Line 1 Street address
`line2` | string | Line 2 Street address
`city` | string | City
`state`  | string | State
`zip5`| int | Zip code
`country` | string | Country
`phone_number` | string | Phone number
`date_of_birth`  | int | Date of birth as Unix timestamp


```shell
curl -X GET http://api.upwardfi.com/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
[{
  "id": "BGMXJzGzJcht38SCJuMhzF",
  "email": "john.smith@gmail.com",
  "first_name": "john",
  "last_name": "smith"
}]
```

# Profiles

## Get User's profile 

This API endpoint returns the user's profile based on the provided user id.

### HTTP Request

`GET http://api.upwardfi.com/users/{id}`

### Path parameter

Parameter | Type | Description
--------- | ------- | -----------
`id` *required* | string | User id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`username` | string | User name 
`email` | string | Email id of user
`first_name` |string | First Name
`last_name` | string | Last Name
`ssn` | string | Social Security Number
`line1` | string | Line 1 Street address
`line2` | string | Line 2 Street address
`city` | string | City
`state`  | string | State
`zip5`| int | Zip code
`country` | string | Country
`phone_number` | string | Phone number
`date_of_birth`  | int | Date of birth as Unix timestamp


```shell
curl -X GET http://api.upwardfi.com/users/BGMXJzGzJcht38SCJuMhzF \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
{
  "email": "john.smith@gmail.com",
  "first_name": "john",
  "last_name": "smith"
}
```

# Employments

## Get employments 

This API endpoint returns the user's employment details based on the provided user id.

### HTTP Request

`GET http://api.upwardfi.com/users/{id}/employments`

### Path parameter

Parameter | Type | Description
--------- | ------- | -----------
`id` *required* | string | User id

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Employment id
`employer_name` | string | Employer name
`job_title` | string | Job title 
`start_date` | int | Employment start date as Unix timestamp
`end_date` |int | Employment end date as Unix timestamp
`last_paid_date` | int | Last paid date as Unix timestamp
`base_pay_amount` | float | Income base pay 
`pay_cycle` | string | Frequency of pay outs e.g. hourly/weekly/bi-weekly etc. 
`employment_type` | string | Employment type e.g. Full-time/Part-time etc.
`employment_status`  | string | Employment status e.g. active/inactive etc.


```shell
curl -X GET http://api.upwardfi.com/users/YtMXJzGzJcht38SCJuMhzC/employments \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
[{
  "id": "GtMXJzGzJcht38SCJuMhvG",
  "employer_name": "Kroger",
  "job_title": "Floor Manager",
  "start_date": "171003600"
}]
```
# Bank Accounts

## Add bank account

This API adds a bank account to an enrollment via Upward.By passing basic bank account information Upward will return a key unique to the user based on the user id.

### HTTP Request

`POST http://api.upwardfi.com/users/{id}/bank_accounts`

### Path parameter

Parameter | Type | Description
--------- | ------- | -----------
`id` *required* | string | User id

### Request Body

Parameter | Type | Description
--------- | ------- | -----------
`account_number` *required* |string | Account number
`routing_number` *required* | string | Routing number
`account_type` *required* | string | Type of account (checking, savings, etc)
`bank_name` *required* | string | Name of bank

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns bank account id.


```shell
curl -X POST http://api.upwardfi.com/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" \
  -d $'{
    "account_number": "874038933",
    "routing_number": "111000614",
    "account_type": "checking",
    "bank_name": "J.P. Morgan Chase"
  }'
```

> The above command returns JSON structured like this:

```json
{
  "id": "GzJcht38SCJuMhzCYtMXJz"
}
```

## Get bank accounts

This API returns user's bank accounts based on the specified user id.

### HTTP Request

`GET http://api.upwardfi.com/users/{id}/bank_accounts`

### Path parameter

Parameter | Type | Description
--------- | ------- | -----------
`id` *required* | string | User id

### Response Body

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Account id
`account_number` |string | Account number
`routing_number` | string | Routing number
`account_ype` | string | Type of account (checking, savings, etc)
`bank_name` | string | Name of bank


```shell
curl -X GET http://api.upwardfi.com/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
[{
  "id": "GtMXJzGzJcht38SCJuMhvG",
  "account_number": "909000614",
  "routing_number": "111000614",
  "account_type": "checking",
  "bank_name": "J.P. Morgan Chase"
}]
```

# Client SDK

## Widget Installation

Upward's widget is a front-end UI element that allows users to grant your application access to their work accounts and to set up automated payments directly from their paychecks. It can be displayed on any part of your application.

### Config parameters

Parameter | Type | Description
--------- | ------- | -----------
`plugin_key` *required* | string | unique key corresponding to their application
`api_host` *required* | string | Link to API environment (Sandbox/Production)
`enrollment_id` *required* | string | Enrollment key that is returned from calling the Enrollments API
`employer_name` *optional* | string | Employer name
`features` *required* | string | Configures enrollment flow. Can be either employment_data/accept_payment/all  

<!-- ### Response -->

<!-- Parameter | Type | Description
--------- | ------- | -----------
user_id | string | unique user id
status | string | response status -->

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <upward-link></upward-link>
  <script src="https://api.upwardfi.com/upward-link.js"></script>
  <script type="text/javascript">
  upwardLink.create({
    plugin_key: 'your_plugin_key',
    api_host: 'https://api-sandbox.upwardfi.com',
    enrollment_id: 'key_from_enrollment_api',
    employer_name: 'Kroger',
    features: 'all',
    on_success: (public_token) => {
    console.log('on_success!' + public_token);
    },
    on_error: () => {
    console.log('on_error!');
    },
    on_close: () => {
    console.log('on_close!');
    }
    });
  upwardLink.open();
  </script>
</body>
</html>
```
<!-- > The above command returns JSON structured like this:

```json
{
    "user_ID": "erj4021",
    "status": "success" 
}
``` -->
