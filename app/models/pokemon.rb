class Pokemon < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :rentals, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :level, presence: true, inclusion: { in: (1..100) }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :race, presence: true
  validates :hp, presence: true, numericality: { greater_than: 0 }
  validates :attack, presence: true, numericality: { greater_than: 0 }
  validates :defense, presence: true, numericality: { greater_than: 0 }
  validates :special_attack, presence: true, numericality: { greater_than: 0 }
  validates :special_defense, presence: true, numericality: { greater_than: 0 }
  validates :speed, presence: true, numericality: { greater_than: 0 }
end
