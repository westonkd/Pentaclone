require 'json'

class GamesController < ApplicationController
  #create a new game and initialize board to nil
  # POST /games
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

  # Make a move in the game
  # POST games/:id/move
  # expects
  # {
  #   "token": string,
  #   "row": int or string, (i.e. '1'or 1)
  #   "col": int or string, (i.e '1' or 1)
  #   "quad": int, (the column to rotate)
  #   (optional) "clockwise": boolean (true to rotate 'quad' clockwise, do not include to rotate counter-clockwise)
  # }
  #
  # returns
  # 404 if game not found
  # 403 if not user's turn or invalid token
  # 400 if user did not specify all required fields or the move is already taken
  def move
    if !(Game.exists?(params[:id]) && Game.find(params[:id]).is_active)
      render(nothing: true, status: 404)
      return
    end

    if !(params[:token] && params[:row] && params[:col] && params[:quad])
      render(nothing: true, status: 400)
      return
    end

    game = Game.find(params[:id])
    player = Player.find_by_token(params[:token])

    #if it is the players turn and they provide a valid token
    if player && player.id != game.last_player_id

      #make the move if it is in bounds and not taken
      if (0..5).include?(params[:row]) && (0..5).include?(params[:col])
        if game.board.board_state[params[:row]][params[:col]] != 0
          render(nothing: true, status: 400)
          return
        end

        #set the piece
        piece = game.player_one == player.id ? 1 : 2
        game.board.board_state[params[:row]][params[:col]] = piece

        #rotate the specified quadrant
        board = ArrayHelper.new(game.board.board_state)
        board.out
        case params[:quad].to_i
          when 1
            board.rotate_quad_one params[:clockwise]
          when 2
            board.rotate_quad_two params[:clockwise]
          when 3
            board.rotate_quad_three params[:clockwise]
          when 4
            board.rotate_quad_four params[:clockwise]
          else
            render(nothing: true, status: 400)
            return
        end
        puts "\n"
        board.out
        game.board.board_state = board.array
      else
        render(nothing: true, status: 404)
        return
      end

      game.last_player_id = player.id

      game.board.save!
      game.save!

      #check for a winner
      if game.board.win?(piece)
        render json: {winner: player.name, board: game.board.board_state.as_json}
        game.winner_id = player.id
        game.is_active = false
        game.save!
        return
      end

      render json: {board: game.board.board_state.as_json}
    else
      render(nothing: true, status: 403)
    end
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
