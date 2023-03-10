class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :first_name
      t.string :last_name
      t.text :title
      t.integer :user_id
      t.timestamps
    end
  end
end
