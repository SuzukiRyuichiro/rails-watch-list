class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, presence: true
end
