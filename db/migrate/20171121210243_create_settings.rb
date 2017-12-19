class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.boolean :enable_sms, default: false
      t.boolean :enable_email, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    #Good for updating existing records with new columns and defaults.
    User.find_each do |user|
      Setting.create(user: user, enable_email: true, enable_sms: false)
    end
  end

end
