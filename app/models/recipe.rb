class Recipe < ApplicationRecord
  belongs_to :user
  has_many :receptions
  validates :name, presence: true, length: { minimum: 3 }

end
