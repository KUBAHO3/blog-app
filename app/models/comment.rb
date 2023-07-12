class Comment < ApplicationRecord
    belongs_to :users
    belongs_to :posts
    
    def update_comments_counter
        post.increment!(:commentsCounter)
    end
end
