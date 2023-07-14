class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  after_save :increment_comments_count

  private

  def increment_comments_count
    post.increment!(:comments_counter)
  end
end
