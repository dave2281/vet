class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
end
