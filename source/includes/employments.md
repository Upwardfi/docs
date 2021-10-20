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
