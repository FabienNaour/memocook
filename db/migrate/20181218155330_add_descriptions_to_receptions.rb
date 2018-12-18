class AddDescriptionsToReceptions < ActiveRecord::Migration[5.2]
  def change
    add_column :receptions, :description, :text
  end
end
