class AddLogosToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :logo, :string
  end
end
