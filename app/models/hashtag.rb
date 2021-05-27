class Hashtag < ApplicationRecord
  HASHTAG_REGEX = /#[[:word:]]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  scope :with_linked_questions, -> { joins(:questions).distinct }
end
