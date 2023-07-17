class User < ApplicationRecord
  validates :name, presence: true
  validate :posts_counter_greater_than_zero

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def most_recent_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def posts_counter_greater_than_zero
    return unless postsCounter.present? && postsCounter.negative?

    errors.add(:postsCounter, 'must be greater than or equal 0')
  end
end
