class AddPhoneNumberToVenues < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :phone_number, :string
  end
end
