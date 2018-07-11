class AddIndextoUserId < ActiveRecord::Migration[5.1]
  def change
    add_index :cats, :user_id
  end
end
