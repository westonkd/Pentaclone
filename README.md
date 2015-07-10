# Pentaclone: A Pentago clone web service

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

## Game Visualizer

## Getting Game Data