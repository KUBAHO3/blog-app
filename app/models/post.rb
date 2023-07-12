class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  after_save :update_post_counter

  def update_post_counter
    user.increment!(:PostsCounter)
  end
end
