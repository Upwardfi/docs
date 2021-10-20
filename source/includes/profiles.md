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
