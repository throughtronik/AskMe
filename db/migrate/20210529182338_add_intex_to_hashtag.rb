class AddIntexToHashtag < ActiveRecord::Migration[6.1]
  def change
    add_index :hashtags, :tag
  end
end
