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

Welcome to Highline - a seamless integration to setting up automated payments directly from your platform user's income. You can initiate enrollment by calling Highline's API endpoints and displaying the widget.

This API reference provides information on available endpoints and how to interact with it.

Highline's API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. All requests should be over SSL. All request and response bodies, including errors are encoded in JSON.

```shell
https://api.highline.co
```
# API Keys

Highline's API uses JWT Token authentication. All API calls must include a bearer token.

<aside class="warning">
    An invalid, missing or expired token will result in HTTP `401` Unauthorized responses.
</aside>

The API key should be kept confidential and only stored on your own servers.

Each account has a total of two keys: a key pair for test mode and live mode.

# Authentication

## Access Token

> Example Request:

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> The above command returns JSON structured like this:
> Note that subject refers to your user ID.

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```
> All API requests must be made over HTTPS. Calls made over plain HTTP will fail. 

The endpoints uses JWT token authentication.

You can have you token via the `API key` which you can find in your accounts settings endpoint. Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

<br />
Response:

Attribute | Type | Description
--------- | ------- | ------ | --------
`access_token` | string | Token used to perform requests
`refresh_token` | string | Token used to request new tokens
`subject` | string | Your API Key
`expires_in` | int | Timestamp of token expire time
<br />
<br />
<br />

### Simple Request with Token

```shell
curl -X GET https://api.highline.co/enrollments/123e4567-e89b-12d3-a456-426614174000 \
  -H "Authorization: Bearer eyJhbGciOiJIUzI..."
  ```
> Note: You will only be allowed to perform this request if this resource (enrollment in this example), refers to you somehow. We do not allow users to fetch alien information.

Authentication to the API is performed via Bearer token. Provide your `access_token` as the Bearer auth value. You do not need to provide the secret again.

## Refresh Token
> Example Request:

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "refresh_token" : "eyJhbGciOiJIUz...",
    "subject":"123e4567-e89b-12d3-a456-426614174000",
    "grant_type": "refresh_token"
  }'
```

> The above command returns JSON structured like this:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

All tokens have a expiration time of 15 minutes.

Once you have your token expired, you can ask a new one using the previous `refresh_token`, that have 30 days of expiration time.

To ask brand new tokens you can do like so:

<br />
Request:

Attribute | Type | Description
--------- | ------- | ------ | --------
`refresh_token` *required* | string | Token used to request new tokens
`subject` *required* | string | Your API Key
`grant_type` *required* | string | Default string "refresh_token"

# Rate limiting

Highline's API are rate limited to prevent abuse that would degrade our ability to maintain consistent API performance for all users. By default, each API key or app is rate limited at 10,000 requests per hour. If your requests are being rate limited, HTTP response code 429 will be returned with an rate_limit_exceeded error.

# Enrollments

## Check if employer is supported
This API checks if user's employer is supported through Highline and will return success or failure based on eligibility.

`GET http://api.highline.co/supported_employers`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`q` *required* | string | query | Employer name

### Response

Name | Type | Description
--------- | ------- | -----------
`is_supported` | boolean | Returns true if supported and false if not. 

```shell
curl -X GET http://api.highline.co/supported_employers?q=Kroger \
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
This API initiates user enrollment via Highline. By passing basic enrollment information Highline will return a key unique to the enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`payment_amount` *optional* | float | body | Recurring amount to be paid to you by the user
`payment_frequency` *optional* | string | body | Frequency interval that user will make payments
`first_payment_date` *optional* | timestamp | body | Date of first payment as Unix timestamp
`application_reference_number` *optional* | string | body | Loan application number
`account_reference_number` *optional* | string | body | Your account reference number
`days_until_expires` *optional* | int | body | Number of days before this enrollment request expires
`required_employment_start_date` *optional* | timestamp | body | Start date of employment as Unix timestamp
`required_gross_income` *optional* | float | body | User gross income
`required_net_income` *optional* | float | body | User net income
`return_w2_data` *optional* | boolean | body | Specify true if user w2 data must be returned
`return_paystubs` *optional* | boolean | body | Specify true if link to user paystubs must be returned

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.


```shell
curl -X POST http://api.highline.co/enrollments \
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

This API endpoint adds a user to the enrollment via Highline. By passing basic user information Highline will return a key unique to the user based on the provided enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id
`username` *required* | string | body | User name 
`email` *required* | string | body | Email id of user
`first_name` *required* |string | body | First Name
`last_name` *required* | string | body | Last Name
`ssn` *required* | string | body | Social Security Number
`address` *required* | json | body | Nested JSON object containing user's address data
`employer` *optional* | string | body | User employer name
`phone` *optional* | string | body | Phone number
`date_of_birth` *optional* | timestamp | body | Date of birth as Unix timestamp

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.


```shell
curl -X POST http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" \
  -d $'{
    "username": "john_smith",
    "first_name" : "John",
    "last_name" : "Smith",
    "email" : "john.smith13@gmail.com",
    "ssn" : "111223333",
    "address" : {
      "id" : 83
      "line_1" : "4194 Autry Lane",
      "line_2" : "",
      "city" : "Dallas",
      "state" : "TX",
      "zip_code" : 75001,
      "country":"US"
    }
  }'
```

> The above command returns JSON structured like this:

```json
{
  "id": "38SCJuMhzCYtMXJzGzJcht"
}
```

## Get enrolled users

This API endpoint returns users that are enrolled based on the provided enrollment id.

### HTTP Request

`GET http://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | User id
`username` | string | User name 
`email` | string | Email id of user
`first_name` |string | First Name
`last_name` | string | Last Name
`ssn` | string | Social Security Number
`address` | json | Address information
`phone` | string | Phone number
`date_of_birth`  | timestamp | Date of birth as Unix timestamp
`created_at` | timestamp | Timestamp user was created 
`updated_at` | timestamp | Timestamp user object was updated

```shell
curl -X GET http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
[{
    "id": "38SCJuMhzCYtMXJzGzJcht",
    "username": "john_smith",
    "first_name" : "John",
    "last_name" : "Smith",
    "email" : "john.smith13@gmail.com",
    "ssn" : "111223333",
    "address" : {
      "id" : 83,
      "line_1":"4194 Autry Lane",
      "line_2":"",
      "city":"Dallas",
      "state":"TX",
      "zip_code":75001,
      "country":"US"
    },
    "created_at":1626701186,
    "updated_at":1626701216
  }]
```

# Profiles

## Get User's profile 

This API endpoint returns the user's profile based on the provided user id.

### HTTP Request

`GET http://api.highline.co/users/{id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | User id
`username` | string | User name 
`first_name` |string | First Name
`last_name` | string | Last Name
`date_of_birth`  | timestamp | Date of birth as Unix timestamp
`ssn` | string | Social Security Number
`address` | json | Address information
`email` | string | Email id of user
`phone` | string | Phone number
`created_at` | timestamp | Timestamp user was created 
`updated_at` | timestamp | Timestamp user object was updated


```shell
curl -X GET http://api.highline.co/users/BGMXJzGzJcht38SCJuMhzF \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
  {
    "id": "BGMXJzGzJcht38SCJuMhzF",
    "username": "robcantor1994",
    "first_name" : "Robert",
    "last_name" : "Cantor",
    "email" : "robcantor94@gmail.com",
    "ssn" : "444556666",
    "address" : {
      "id" : 12,
      "line_1":"110 Lois Lane",
      "line_2":"",
      "city":"Kaufman",
      "state":"TX",
      "zip_code":75142,
      "country":"US"
    },
    "phone": "5551293040",
    "created_at":1626702186,
    "updated_at":1626703216
  }
```

## Address Fields

A user's address is represented by another JSON object nested inside the User's JSON object. 

Parameter | Type | Description
----------|----------|---------
`id` | uint | Address id
`user_id` | string | User id associated with address
`company_id` | string | Client company id
`line_1` | string | Line 1 Street address
`line_2` | string | Line 2 Street address
`city` | string | City
`state` | string | State
`zip_code` | string | Zip code
`country` | string | Country

# Employments

## Get employments 

This API endpoint returns the user's employment details based on the provided user id.

### HTTP Request

`GET http://api.highline.co/users/{id}/employments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Employment id
`job_title` | string | Job title 
`hire_datetime` | timestamp | Employment start date as Unix timestamp
`termination_datetime` |timestamp | Employment end date as Unix timestamp
`last_pay_date` | timestamp | Last paid date as Unix timestamp
`base_pay` | float | Income base pay 
`pay_cycle` | string | Frequency of pay outs e.g. hourly/weekly/bi-weekly etc. 
`type` | string | Employment type e.g. Full-time/Part-time etc.
`status`  | string | Employment status e.g. active/inactive etc.


```shell
curl -X GET http://api.highline.co/users/YtMXJzGzJcht38SCJuMhzC/employments \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
[{
  "id": "GtMXJzGzJcht38SCJuMhvG",
  "job_title": "Floor Manager",
  "hire_datetime": 1592862445,
  "last_pay_date": 1624398445,
  "base_pay": 23454.65,
  "pay_cycle": "bi-weekly",
  "type": "full-time",
  "status": "active"
}]
```
# Bank Accounts

## Add bank account

This API adds a bank account to an enrollment via Highline. By passing basic bank account information Highline will return a key unique to the user based on the user id.

### HTTP Request

`POST http://api.highline.co/users/{id}/bank_accounts`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`account_number` *required* |string | body | Account number
`routing_number` *required* | string | body | Routing number
`account_type` *required* | string | body | Type of account (checking, savings, etc)
`bank_name` *required* | string | body | Name of bank

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns bank account id.


```shell
curl -X POST http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
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

`GET http://api.highline.co/users/{id}/bank_accounts`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Account id
`account_number` |string | Account number
`routing_number` | string | Routing number
`account_type` | string | Type of account (checking, savings, etc)
`bank_name` | string | Name of bank
`is_virtual` | boolean | Specifies whether this account is a virtual account or not
`created_at` | timestamp | Timestamp bank account was created 
`updated_at` | timestamp | Timestamp bank account was updated

```shell
curl -X GET http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
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
  "is_virtual": false,
  "bank_name": "J.P. Morgan Chase"
}]
```

<!-- ## Get bank account

This API returns bank account details based on the specified user and bank account id.

### HTTP Request

`GET http://api.highline.co/users/{id}/bank_accounts/{bank_account_id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id

### Response 

Parameter | Type | Description
--------- | ------- | -----------
`account_number` |string | Account number
`routing_number` | string | Routing number
`account_ype` | string | Type of account (checking, savings, etc)
`bank_name` | string | Name of bank
`created_at` | timestamp | Timestamp bank account was created 
`updated_at` | timestamp | Timestamp bank account was updated

```shell
curl -X GET http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts/GtMXJzGzJcht38SCJuMhvG \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json" 
```

> The above command returns JSON structured like this:

```json
{
  "account_number": "909000614",
  "routing_number": "111000614",
  "account_type": "checking",
  "bank_name": "J.P. Morgan Chase"
}
``` -->





# Client SDK

## Widget Installation

Highline's widget is a front-end UI element that allows users to grant your application access to their work accounts and to set up automated payments directly from their paychecks. It can be displayed on any part of your application. There are two ways to connect to the Highline Link. You can connect via a one-step or a two-step process.

## One-Step Connection

### Config parameters

Name | Type | Description
--------- | ------- | -----------
`plugin_key` *required* | string | Unique key corresponding to their application
`api_host` *required* | string | Link to API environment (Sandbox/Production)
`enrollment_id` *required* | string | Enrollment key that is returned from calling the Enrollments API
`product_id` *required* | string | Unique key provided via Highline's Client Portal

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <highline-link></highline-link>
  <script src="https://highline-link-staging.s3.us-east-2.amazonaws.com/highline-link.js"></script>
  <script type="text/javascript">
    highlineLink.createPayrollPaymentConnection({
      plugin_key: 'your_plugin_key',
      api_host: 'https://stg-api.highline.co',
      enrollment_id: 'key_from_enrollment_api',
      product_id: 'key_from_client_portal',
      on_success: ({ user_id }) => {
        console.log('on_success! ' + user_id);
      },
      on_error: () => {
        console.log('on_error!');
      },
      on_close: () => {
        console.log('on_close!');
      }
    });
    highlineLink.open();
  </script>
</body>
</html>
```

## Two-Step Connection

### Config Parameters

Name | Type | Description
--------- | ------- | -----------
`plugin_key` *required* | string | Unique key corresponding to their application
`api_host` *required* | string | Link to API environment (Sandbox/Production)
`product_id` *required* | string | Unique key provided via Highline's Client Portal
`payroll_connection_id` *required* | string | Id returned by Payroll Data Connection process
`enrollment_id` *required* | string | Enrollment key that is returned from calling the Enrollments API

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <highline-link></highline-link>
  <script src="https://highline-link-staging.s3.us-east-2.amazonaws.com/highline-link.js"></script>
  <script type="text/javascript">
    // Step 1 - Payroll Data Connection
    connectEmploymentData = () => {
      highlineLink.createPayrollDataConnection({
        plugin_key: 'your_plugin_key',
        api_host: 'https://stg-api.highline.co',
        product_id: 'key_from_client_portal',
        on_success: ({ payroll_connection_id, user_id }) => {       
          console.log('Payroll Connection ', payroll_connection_id, ' User ID:', user_id);
        },
        on_error: () => {
          console.log('on_error!');
        },
        on_close: () => {
          console.log('on_close!');
        }
      });
      highlineLink.open();
    }
    // Step 2 - Payment Connection
    connectPayrollPayment = () => {
      highlineLink.createPayrollPaymentConnection({
        plugin_key: 'your_plugin_key',
        api_host: 'https://stg-api.highline.co',
        payroll_connection_id: 'id_from_highline_link_callback',
        enrollment_id: 'key_from_enrollment_api',
        product_id: 'key_from_client_portal',
        on_success: ({ user_id }) => {
          console.log('on_success! ' + user_id);
        },
        on_error: () => {
          console.log('on_error!');
        },
        on_close: () => {
          console.log('on_close!');
        }
      });
      highlineLink.open();
    }
  </script>
</body>
</html>
```