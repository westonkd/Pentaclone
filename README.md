# Pentaclone: A Pentago clone web service
Pentaclone is a game server that provides a REST API to play a clone of the game Pentago.

## Getting Started
1. Install gems `bundle install`
2. Create DB `rake db:create`
3. Run migrations `rake db:migrate`
4. Start the server `rails s`

## Creating a Game
1. Make a post to `/games`
2. The response will be return the id of the new game formatted as JSON:
```
  {
    "game_id":<id of new game>
  }
```

## Joining a Game
1. Make a post to `/games/<id of game to join>/join` with your player name formatted as raw JSON in the POST:

### Request
```
 {
    "name":"player name"
 }
```

### Response
```
{
  "player_token":"1208ad47-316c-4826-821a-27074b85c873", //A UUID assigned to the newly added player for verification when making moves.
  "first_move":true //A boolean flag indicating if the new player has the first move.
}
```

## Making a Move
1. Make a post to `games/<id of game to make move in>/move` with the move data formatted as raw JSON in the POST:

### Request

```
{
  "token": "<player token>", //string
  "row": <row>,              //integer
  "col": <column>,           //integer
  "quad": <quadrant to rotate>, //integer
  "clockwise": <indicates which direction to rotate 'quad'> //Boolean
}
```

For example the following request would place a piece in row 3 column 4 and rotate quadrant 4 clockwise if it is the player's turn and their token is valid:

```
{
  "token": "45901c0c-173f-4fd1-a651-e0b54ae3ef19",
  "row": 3,
  "col": 4,
  "quad": 4,
  "clockwise": true
}
```

To rotate a quadrant counter-clockwise leave out the "clockwise" property:

```
{
  "token": "45901c0c-173f-4fd1-a651-e0b54ae3ef19",
  "row": 3,
  "col": 4,
  "quad": 4
}
```

Quadrants are labeled the same as a standard Cartesian plane:

```
II | I
---+---
III|IV
```

## Game Visualizer
Penticlone has a build-in game visualizer to easily see active and past games. The visualizer also allows a player to make moves using a simple interface. To view an active or past game navigate to `/games/<game id of game to see>/viz`. To make a move in an active game click on an empty slot and provide your player token.

## Getting Game Data
### Get All Games
#### Request
```
GET /games
```

#### Example Response
```
  [
    {"id":1,"player_one":1,"player_two":2,"created_at":"2015-07-09T21:19:21.182Z","updated_at":"2015-07-09T21:26:14.475Z","is_active":false,"last_player_id":2,"winner_id":1},
    {"id":5,"player_one":10,"player_two":12,"created_at":"2015-07-09T23:45:51.370Z","updated_at":"2015-07-09T23:54:02.567Z","is_active":false,"last_player_id":10,"winner_id":12}
  ]
```

### Get Single Game
#### Request
```
GET /games/<game id>
```

#### Example Response
```
{
  "id":5,
  "player_one":10,
  "player_two":12,
  "created_at":"2015-07-09T23:45:51.370Z",
  "updated_at":"2015-07-09T23:54:02.567Z",
  "is_active":false,"last_player_id":10,
  "winner_id":12
}
```
