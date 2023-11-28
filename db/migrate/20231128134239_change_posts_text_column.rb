class ChangePostsTextColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :text, :text
  end
end
