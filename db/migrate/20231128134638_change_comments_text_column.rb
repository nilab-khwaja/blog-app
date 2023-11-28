class ChangeCommentsTextColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :text, :text
  end
end
