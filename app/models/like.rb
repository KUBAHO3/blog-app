class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  after_save :increment_likes_count

  private

  def increment_likes_count
    post.increment!(:likes_counter)
  end
end
