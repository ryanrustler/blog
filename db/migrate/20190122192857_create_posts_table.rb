class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :comment
      t.references :user
      t.timestamps
  end
end
end

