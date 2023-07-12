class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :AuthorId
      t.integer :PostId
      t.text :Text
      t.date :UpdatedAt
      t.date :CreatedAt

      t.timestamps
    end
  end
end
