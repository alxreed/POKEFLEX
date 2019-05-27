class Pokemon < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :rentals, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :level, presence: true, inclusion: { in: (1..100) }
  validates :price, presence: true
end
