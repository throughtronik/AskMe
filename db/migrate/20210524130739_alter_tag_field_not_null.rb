class AlterTagFieldNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:hashtags, :tag, false)
  end
end
