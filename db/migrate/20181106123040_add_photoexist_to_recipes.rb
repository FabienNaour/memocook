class AddPhotoexistToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :photoexist, :boolean
  end
end
