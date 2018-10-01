class CreateReceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :receptions do |t|
      t.datetime :date
      t.references :friend, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
