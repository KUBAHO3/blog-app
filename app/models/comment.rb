class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  after_save :increment_comments_count
  after_destroy { increment_comments_count(false) }

  private

  def increment_comments_count(increment: true)
    if increment
      author.increment!(:postsCounter)
    else
      author.decrement!(:postsCounter)
    end
  end
end
