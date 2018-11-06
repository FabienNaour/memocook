class Recipe < ApplicationRecord
  belongs_to :user
  has_many :receptions , :dependent => :destroy
  has_many :friends, through: :receptions
  validates :name, presence: true, length: { minimum: 3 }
  mount_uploader :photo, PhotoUploader

end
