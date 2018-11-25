class AddAvatarsToFriends < ActiveRecord::Migration[5.2]
  def change
    add_column :friends, :avatar, :string
  end
end
