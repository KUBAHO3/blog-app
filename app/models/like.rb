class Like < ApplicationRecord
  belongs_to :users
  belongs_to :posts

  def update_likes_counter
    post.increment!(:likesCounter)
  end
end
