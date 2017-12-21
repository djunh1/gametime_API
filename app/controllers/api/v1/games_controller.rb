class Api::V1::GamesController < ApplicationController
  #new 6
  def index

    if !params[:address].blank?
      games = Game.where(active: true).near(params[:address], 15, order: 'distance')
    else
      games = Game.where(active: true)
    end

    if !params[:start_date].blank?
      start_date = DateTime.parse(params[:start_date])

      games = games.select { |game|
        #count number of reservations that occur on statrt_date
        #might be a better way to impliment roster sizes
        #TODO research this for web app.
        reservations = Reservation.where(
          "game_id = ? AND (start_date <= ?) AND status = ?",
          game_id, start_date, 1
        ).count

        #check unavailable dates
        calendars = Calendar.where(
          "game_id = ? AND status = ? AND day BETWEEN ? AND ?",
          game_id, 1, start_date, start_date
        ).count

        reservations == 0 && calendars == 0
        }
    end

    render json: {
      games: games.map { |game|
        game.attributes.merge(image: game.cover_photo('medium'), instant: game.instant != "Request")
      },
      is_success: true
    }, status: :ok

  end

  def show
    game = Game.find(params[:id])

    today = Date.today
    reservations = Reservation.where(
      "game_id = ? AND start_date >= ? AND status = ?",
      params[:id], today, 1
    )
    #transform reservations we get from DB
    unavailable_dates = reservations.map { |r|
      (r[:start_date].to_datetime..r[:start_date].to_datetime).map{ |day| day.strftime("%Y-%m-%d") }
    }.flatten.to_set

    #gets only the day via pluck
    calendars = Calendar.where(
      "game_id = ? AND status = ? and day >= ?",
      params[:id], 1, today
      ).pluck(:day).map(&:to_datetime).map { |day| day.strftime("%Y-%m-%d") }.flatten.to_set

    unavailable_dates.merge calendars

    if !game.nil?
      game_serializer = GameSerializer.new(
        game,
        image: game.cover_photo('medium'),
        unavailable_dates: unavailable_dates
      )
      render json: {game: game_serializer, is_success: true}, status: :ok
    else
      render json: {error: 'Invalid game id', is_success: false}, status: 422
    end

  end
  # new 10
  def your_listings
    games = current_user.games
    render json: {
      games: games.map { |g| g.attributes.merge(image: g.cover_photo('medium'), instant: g.instant != "Request") },
      is_success: true
    }, status: :ok

  end
end
