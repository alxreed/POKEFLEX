class Rental < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user
  validates :starting_date, presence: true
  validates :ending_date, presence: true
end
