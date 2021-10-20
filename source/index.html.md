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

```shell
https://api.highline.co
```

Welcome to Highline - a seamless integration to setting up automated payments directly from your platform user's income. You can initiate enrollment by calling Highline's API endpoints and displaying the widget.

This API reference provides information on available endpoints and how to interact with it.

Highline's API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. All requests should be over SSL. All request and response bodies, including errors are encoded in JSON.

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

> Response

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

The endpoints uses JWT token authentication.

You can have you token via the `API key` which you can find in your accounts settings endpoint. Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

### Parameters

Attribute | Type | Description
--------- | ------- | ------ | --------
`access_token` | string | Token used to perform requests
`refresh_token` | string | Token used to request new tokens
`subject` | string | Your API Key
`expires_in` | int | Timestamp of token expire time

Authentication to the API is performed via Bearer token. Provide your `access_token` as the Bearer auth value. You do not need to provide the secret again.

### HTTP Request

```shell
curl -X GET https://api.highline.co/enrollments/123e4567-e89b-12d3-a456-426614174000 \
  -H "Authorization: Bearer eyJhbGciOiJIUzI..."
  ```

`GET http://api.highline.co/enrollments/{id}`

All API requests must be made over HTTPS. Calls made over plain HTTP will fail.

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

> Response

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

# Employers

## Check if employer is supported

```shell
curl -X GET http://api.highline.co/employers?q=Kroger \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[
  {
    "id": "25de3...",
    "name_hash": "bd545...",
    "name": "Kroger",
    "type": "retail",
    "has_two_fa": false,
    "api_supported": true,
    "can_edit_allocations": false,
    "max_number_of_allocations": 5,
    "exclude_employer_enabled": false,
    "created_at": 1633824000,
    "updated_at": 1634428800
  }
]
```

This API checks if user's employer is supported through Highline and will return success or failure based on eligibility.

`GET http://api.highline.co/employers`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`q` *required* | string | query | Employer name

### Response

Array of Employers Data that match query

# Enrollments

## Create user enrollment

```shell
curl -X POST http://api.highline.co/enrollments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "users": [{
      "id": "1324defc-a8e..."
    }],
    "product_id": "6351fsd6fs-sdfs...",
    "payment_amount": 20000,
    "payment_frequency": "monthly",
    "first_payment_date": 1634740754,
    "application_reference_number": "16576",
    "days_until_expires": 30
  }'
```

> Response

```json
{
  "id": "DVNA4...",
  "users": [
    {
      "id": "1324defc-a8...",
      "provider_user_id": "",
      "email": "",
      "role": "",
      "ofac_validated": false,
      "created_at": 1634741667,
      "updated_at": 1634741667
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576",
  "days_until_expires": 30,
  "fully_synced": false,
  "status": "new",
  "status_description": "",
  "created_at": 1634741667,
  "updated_at": 1634741667
}
```

This API initiates user enrollment via Highline. By passing basic enrollment information Highline will return an object to the enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`users` | array | body | Array of user objects that contain the member user ID
`product_id` | string | body | Product ID
`payment_amount` | int | body | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | body | Frequency interval that user will make payments ("unknown" "bi-weekly even" "bi-weekly odd" "weekly" "monthly" "semi-monthly")
`first_payment_date` | timestamp | body | Date of first payment as Unix timestamp
`application_reference_number` *optional* | string | body | Loan application number
`days_until_expires` | int | body | Number of days before this enrollment request expires

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.
`users` | array | Returns array of users.
`product_id` | string | product id.
`payment_amount` | int | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | Frequency interval that user will make payments
`first_payment_date` | timestamp | Date of first payment as Unix timestamp
`application_reference_number` | string | Loan application number
`days_until_expires` | int | Number of days before this enrollment request expires
`fully_synced` | bool | 
`status` | string | Enrollment status
`status_description` | string | Description of status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update


## Add users to enrollments

```shell
curl -X POST http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "first_name" : "John",
    "last_name" : "Smith",
    "email" : "john.smith13@highline.co",
    "ssn" : "12345...",
    "role" : "member",
    "address" : {
      "id" : 83,
      "line_1" : "4194 Autry Lane",
      "line_2" : "",
      "city" : "Dallas",
      "state" : "TX",
      "zip_code" : "75001",
      "country":"US"
    }
  }'
```

> Response

```json
{
  "id": "d134c.....",
  "provider_user_id": "Argyle",
  "first_name": "John",
  "last_name": "Smith",
  "ssn": "1234...",
  "address": {
    "id": 27,
    "user_id": "d134c.....",
    "company_id": null,
    "line_1": "4194 Autry Lane",
    "line_2": "",
    "city": "Dallas",
    "state": "TX",
    "zip_code": "75001",
    "country": "US"
  },
  "email": "john.smith143@highline.co",
  "role": "member",
  "ofac_validated": false,
  "created_at": 1634744601,
  "updated_at": 1634744601,
  "social_security_number_hash": "08e3...."
}
```

This API endpoint adds a user to the enrollment via Highline. By passing basic user information Highline will return an user object based on the provided enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`email` *required* | string | body | Email id of user
`first_name` *required* |string | body | First Name
`last_name` *required* | string | body | Last Name
`ssn` *required* | string | body | Social Security Number
`address` *required* | json | body | Nested JSON object containing user's address data
`phone` *optional* | string | body | Phone number
`date_of_birth` *optional* | timestamp | body | Date of birth as Unix timestamp

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.
`provider_user_id` | string | ID of employer
`first_name` | string | First Name
`last_name` | string | Last Name
`ssn` | string | Social security number
`address` | json | Address structure  
`role` | string | Member's role 
`ofac_validated` | bool | Ofac validation
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
`social_security_number_hash` | string | SSN hashed


## Get enrollment

```shell
curl -X GET http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
{
  "id": "DVNA...",
  "users": [
    {
      "id": "d134c608-5a...",
      "provider_user_id": "",
      "first_name": "John",
      "last_name": "Smith",
      "ssn": "123456516",
      "email": "john.smith143@highline.co",
      "role": "member",
      "ofac_validated": false,
      "created_at": 1634744601,
      "updated_at": 1634744601,
      "social_security_number_hash": "08e3..."
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576",
  "days_until_expires": 30,
  "fully_synced": false,
  "status": "new",
  "status_description": "",
  "created_at": 1634741667,
  "updated_at": 1634744602
}
```

This API endpoint returns enrollment based on the provided enrollment ID.

### HTTP Request

`GET http://api.highline.co/enrollments/{id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.
`users` | array | Returns array of users.
`product_id` | string | product id.
`payment_amount` | int | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | Frequency interval that user will make payments
`first_payment_date` | timestamp | Date of first payment as Unix timestamp
`application_reference_number` | string | Loan application number
`days_until_expires` | int | Number of days before this enrollment request expires
`fully_synced` | bool | 
`status` | string | Enrollment status
`status_description` | string | Description of status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

## Get enrolled users

```shell
curl -X GET http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "d134c.....",
  "provider_user_id": "Argyle",
  "first_name": "John",
  "last_name": "Smith",
  "ssn": "1234...",
  "address": {
    "id": 27,
    "user_id": "d134c.....",
    "company_id": null,
    "line_1": "4194 Autry Lane",
    "line_2": "",
    "city": "Dallas",
    "state": "TX",
    "zip_code": "75001",
    "country": "US"
  },
  "email": "john.smith143@highline.co",
  "role": "member",
  "ofac_validated": false,
  "created_at": 1634744601,
  "updated_at": 1634744601,
  "social_security_number_hash": "08e3...."
}]
```


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
`id` | string | Returns user id.
`provider_user_id` | string | ID of employer
`first_name` | string | First Name
`last_name` | string | Last Name
`ssn` | string | Social security number
`address` | json | Address structure  
`role` | string | Member's role 
`ofac_validated` | bool | Ofac validation
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
`social_security_number_hash` | string | SSN hashed

# Profiles

## Get User's profile

```shell
curl -X GET http://api.highline.co/users/BGMXJzGzJcht38SCJuMhzF \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

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

This API endpoint returns the user's profile based on the provided user id.

`GET http://api.highline.co/users/{id}`


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

### Address Object

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

```shell
curl -X GET http://api.highline.co/users/YtMXJzGzJcht38SCJuMhzC/employments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

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

# Bank Accounts

## Add bank account

```shell
curl -X POST http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "account_number": "874038933",
    "routing_number": "111000614",
    "account_type": "checking",
    "bank_name": "J.P. Morgan Chase"
  }'
```

> Response

```json
{
  "id": "GzJcht38SCJuMhzCYtMXJz"
}
```

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

## Get bank accounts

```shell
curl -X GET http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

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

Highline's widget is a front-end UI element that allows users to grant your application access to their work accounts, set up automated payments, and switch deposits directly from their paychecks.

To use Highline-Link, pass in an object with the following parameters to the `highlineLink.connect()` function:

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`payload` *required* | string | Encrypted value from the '/link/encode' endpoint
`on_success` *optional* | function | Callback function for success events
`on_error` *optional* | function | Callback function for error events
`on_close` *optional* | function | Callback function for close events


And then open with highlineLink.open()

## Direct Deposit Switch Guide

> Step 1

```javascript
curl -X POST 'http://api.highline.co/auth/token'
-H "Authorization Bearer: AccessToken" \
-d $'{
  "api_key": "YOUR_API_KEY",
  "secret" : "YOUR_SECRET"
}'
```

> Response:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

> Step 2

```javascript
curl -X POST 'http://api.highline.co/link/encode'
Bearer AccessToken
-H "Authorization Bearer: AccessToken" \
-d $'{
 "bank_account": {
   "bank_name": "New Bank",
   "account_type": "checking",
   "routing_number": "XXXXXXXX",
   "account_number": "XXXXXXXXXX"
 },
 "feature": "direct_deposit_switch"
}'
```

> Response:
```json
{
 "payload": "encrypted_value",
}
```

> Step 3

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <highline-link></highline-link>
  <script src="https://link.highline.co/v1/highline-link.js"></script>
  <script type="text/javascript">
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        payload: 'value_from_link_encode_api',
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

### Step 1 - Get an access token from your server

### Step 2 - Build the payload

### Step 3 - Connect and open Highline-Link
