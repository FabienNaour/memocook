class Reception < ApplicationRecord
  belongs_to :friend
  belongs_to :recipe

  validates :date, presence: true

end
