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
``

<small>O ID é o número da reserva</small>


