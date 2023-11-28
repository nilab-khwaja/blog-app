class ChangeUserBioColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :bio, :text
  end
end
