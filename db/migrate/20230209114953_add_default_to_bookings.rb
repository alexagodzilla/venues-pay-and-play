class AddDefaultToBookings < ActiveRecord::Migration[7.0]
  def change
    change_column_default :bookings, :confirmed, from: nil, to: false
  end
end
