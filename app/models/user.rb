class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pokemons, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :rentals, dependent: :destroy
  # validates :first_name, presence: true, allow_blank: false
  # validates :last_name, presence: true, allow_blank: false
  # validates :adress, presence: true
  mount_uploader :photo, PhotoUploader
end
