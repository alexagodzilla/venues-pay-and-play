class AddPhoneNumberToVenues < ActiveRecord::Migration[7.0]
  def change
    unless column_exists? :venues, :phone_number
    add_column :venues, :phone_number, :string
  end
end
end
