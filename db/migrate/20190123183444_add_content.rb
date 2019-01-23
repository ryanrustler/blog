class AddContent < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :users, index: true
    add_foreign_key :posts, :users
  end
end


