class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :AuthorId
      t.text :Title
      t.text :Text
      t.date :CreatedAt
      t.date :UpdatedAt
      t.integer :CommentsCounter
      t.integer :LikesCounter

      t.timestamps
    end
  end
end
