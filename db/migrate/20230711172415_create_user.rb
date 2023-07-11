class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :Name
      t.text :Photo
      t.text :Bio
      t.date :UpdatedAt
      t.date :CreatedAt
      t.integer :PostsCounter

      t.timestamps
    end
  end
end
