class Question < ApplicationRecord
  belongs_to :user

  belongs_to :author, class_name: :User, optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, presence: true, length: { maximum: 255, message: "is more than 255 symbols" }

  after_save_commit :scan_and_save_hashtags
  after_update_commit :delete_all_binded_hashtags

  private

  def delete_all_binded_hashtags
    HashtagQuestion.where(question: self).destroy_all
  end

  def scan_and_save_hashtags
    "#{text} #{answer}".scan(Hashtag::HASHTAG_REGEX)
        .map(&:downcase)
        .uniq
        .each do | hashtag |
          new_hashtag = Hashtag.find_or_create_by(tag: hashtag.delete("#"))
          HashtagQuestion.create!(question: self, hashtag: new_hashtag)
    end
  end
end
