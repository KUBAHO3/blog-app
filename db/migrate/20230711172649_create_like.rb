class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :AuthorId
      t.integer :PostId
      t.date :CreatedAt
      t.date :UpdatedAt

      t.timestamps
    end
  end
end
