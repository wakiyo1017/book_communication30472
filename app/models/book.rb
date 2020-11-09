class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :impression, presence: true
  validates :author, presence: true
end
