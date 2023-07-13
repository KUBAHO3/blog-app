class User < ApplicationRecord
  validates :Name, presence: true
  validates :PostsCounter, numericality: { greater_than_or_equal_to: 0 }
  has_many :posts
  has_many :comments
  has_many :likes

  def recent_post
    posts.order('created_at Desc').limit(3)
  end
end
