class Friend < ApplicationRecord
  belongs_to :user
  has_many :receptions
  has_many :recipes, through: :receptions

  validates :name, presence: true, length: { minimum: 3 }


end
