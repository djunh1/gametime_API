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
end
