class Friend < ApplicationRecord
  belongs_to :user
  has_many :receptions , :dependent => :destroy

  has_many :recipes, through: :receptions

  validates :name, uniqueness: true, presence: true, length: { minimum: 3 , maximum: 15 }
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :telephone, format: { with: /\A(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}\z/ }


end
