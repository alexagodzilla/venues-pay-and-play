class AddPicUrlToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :pic_url, :string
  end
end
