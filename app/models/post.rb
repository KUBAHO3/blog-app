class Post < ApplicationRecord
  validates :Title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, numericality: { greater_than_or_equal_to: 0 }
  validates :LikesCounter, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :user

  has_many :comments
  has_many :likes

  def recent_post
    posts.order(created_at: :desc).limit(3)
  end

  after_save :update_post_counter

  def update_post_counter
    user.increment!(:PostsCounter)
  end
end
