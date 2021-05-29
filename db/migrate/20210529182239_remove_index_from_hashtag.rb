class RemoveIndexFromHashtag < ActiveRecord::Migration[6.1]
  def change
    remove_index Hashtag, :tag
  end
end
