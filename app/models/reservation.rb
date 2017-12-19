class Reservation < ApplicationRecord
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  belongs_to :user
  belongs_to :game

  after_create_commit :create_notification

  #passing in status dynamically.  fetching records from DB using join.
  scope :current_week_revenue, -> (user) {
    joins(:game)
    .where("games.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private

  def create_notification
    type = self.game.Instant? ? "New Game Booking" : "New Game Request"
    guest = User.find(self.user_id)

    Notification.create(content: "#{type} from #{guest.fullname}", user_id: self.game.user_id)
  end

end
