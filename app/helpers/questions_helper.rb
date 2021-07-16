module QuestionsHelper
  def highlight_hashtags_in_text(text)
    raw(
      text.gsub(Hashtag::HASHTAG_REGEX) do |tag|
        link_to tag, hashtag_path(tag.downcase.delete('#'))
      end
    )
  end
end
