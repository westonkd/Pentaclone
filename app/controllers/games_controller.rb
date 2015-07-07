require 'json'

class GamesController < ApplicationController
  #create a new game and initialize board to nil
  # POST games/new
  #
  # returns
  # {
  #   game_id: integer
  # }
  def create
    game = Game.new
    game.board = Board.new(board_state: Array.new(6){Array.new(6){0}})
    game.is_active = false
    game.save!
    render json: {game_id: game.id}
  end

  # join a game if it exists
  # POST games/:id/join
  #
  # expects
  # {"name": "player_name"}
  #
  # returns
  # {
  #   "player_token": string
  #   "first_move": boolean
  # }
  def join
    if !Game.exists?(id: params[:id]) || !params[:name]
      render nothing: true, status: 404
      return
    end

    game = Game.find(params[:id])
    new_player = Player.new()
    new_player.name = params[:name].to_s
    new_player.token = SecureRandom.uuid
    new_player.game = game
    new_player.save!

    first_move = false

    #check if game is full
    if game.player_one && game.player_two
      render nothing: true, status: 400
    else
      if game.player_one
        game.player_two = new_player.id
        game.is_active = true
        game.last_player_id = new_player.id
      else
        game.player_one = new_player.id
        first_move = true
      end

      game.save!
      render json: {player_token: new_player.token, first_move: first_move}
    end
  end

  #going to need game id (in url) player token (in post body) and move (x,y)
  def move
    render json: {move: "test"}
  end

  # shows a single game if it exists.
  # {
  #   "id":integer,
  #   "player_one":integer,
  #   "player_two":integer,
  #   "created_at":"datetime",
  #   "updated_at":"datetime",
  #   "is_active":boolean
  # }
  def show
    if Game.exists?(id: params[:id])
      render json: Game.find(params[:id]).as_json
    else
      render nothing: true, status: 404
    end
  end

  # gets a list of all games
  # [
  #   {
  #     "id":integer,
  #     "player_one":integer,
  #     "player_two":integer,
  #     "created_at":"datetime",
  #     "updated_at":"datetime",
  #     "is_active":boolean
  #   }
  # ]
  def index
    games = []
    Game.all.each do |game|
      games << game.as_json
    end
    render json: games.to_json
  end
end
