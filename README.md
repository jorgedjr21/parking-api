# PARKING API

![Parking API](https://github.com/jorgedjr21/parking-api/workflows/Parking%20API/badge.svg?branch=master)

Just a simple api to manage Entrances, Payment and Exits of a Parking Lot

## API ROUTES

### Entrada
```
POST /parking

REQUEST BODY { plate: 'FAA-1234' }

RESPONSE: 
STATUS 201
{
  "message": "Vehicle entrance with success",
  "data": {
    "id": 9,
    "plate": "AAA-1234",
    "created_at": "2020-04-23T21:00:57.060-03:00",
    "updated_at": "2020-04-23T21:00:57.060-03:00",
    "paid_at": null,
    "exit_at": null
  },
  "status": 201
}
```

<small>O ID é o número da reserva</small>

SAÍDAS
```
PUT /parking/:id/out


{
  "message": "Vehicle AAA-1234 out with success",
  "data": {
    "id": 8,
    "time": "about 3 hours",
    "paid": true,
    "parked_at": "23 April, 2020, 15:32:03",
    "paid_at": "23 April, 2020, 18:55:06",
    "exit_at": "23 April, 2020, 18:59:06"
  }
}

ou

{
  "message": "Vehicle AAA-1234 didn't pay the parking time and can't exit",
  "status": 403
}
```

PAGAMENTO

```
PUT /parking/:id/pay

{
  "message": "Parking payment done",
  "data": {
    "id": 9,
    "time": null,
    "paid": true,
    "parked_at": "23 April 2020, 21:00:09",
    "paid_at": "23 April 2020, 21:08:09",
    "exit_at": null
  },
  "status": 200
}

ou

{
  "message": "Parking payment done before",
  "data": {
    "id": 8,
    "time": "about 3 hours",
    "paid": true,
    "parked_at": "23 April 2020, 15:32:03",
    "paid_at": "23 April 2020, 18:55:06",
    "exit_at": "23 April 2020, 18:59:06"
  },
  "status": 200
}
```

HISTÓRICO

```
GET /parking/:plate

[
  {
    "id": 2,
    "time": null,
    "paid": false,
    "parked_at": "23 April 2020, 13:31:01",
    "paid_at": null,
    "exit_at": null
  },
  {
    "id": 3,
    "time": null,
    "paid": false,
    "parked_at": "23 April 2020, 13:46:01",
    "paid_at": null,
    "exit_at": null
  },
  {
    "id": 7,
    "time": "about 4 hours",
    "paid": true,
    "parked_at": "23 April 2020, 15:16:03",
    "paid_at": "23 April 2020, 18:23:06",
    "exit_at": "23 April 2020, 18:51:06"
  },
  {
    "id": 8,
    "time": "about 3 hours",
    "paid": true,
    "parked_at": "23 April 2020, 15:32:03",
    "paid_at": "23 April 2020, 18:55:06",
    "exit_at": "23 April 2020, 18:59:06"
  }
]
```

# How to Install

**[Install Instructions](https://github.com/jorgedjr21/parking-api/blob/master/INSTALL.md)**
