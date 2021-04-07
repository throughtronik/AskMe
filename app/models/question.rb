class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true, length: { maximum: 255, message: "is more than 255 symbols" }
end
