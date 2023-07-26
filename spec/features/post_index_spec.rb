require 'rails_helper'

RSpec.describe 'User posts', type: :system, js: true do
  before(:all) do
    @messi = User.create(name: 'Messi', photo: 'https://picsum.photos/200/300',
                         bio: 'I love Barcelona and Argentina.')
    @cr7 = User.create(name: 'Cristiano', photo: '/assets/default_user.png',
                       bio: 'I am ubleivable inside the pitch.')

    @messi_post1 = Post.create(title: 'The good old days', text: 'I miss the old days. Those days were the best.',
                               author: @messi)
    @messi_post2 = Post.create(title: 'Second Post', text: 'This is the second post.', author: @messi)
    @messi_post3 = Post.create(title: 'Third Post', text: 'This is the third post.', author: @messi)
    @messi_post4 = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @messi)

    @comment1 = Comment.create(text: 'Wassup G!', author: @cr7, post: @messi_post1)
    @comment2 = Comment.create(text: "I'm not feeling too good, G!", author: @messi, post: @messi_post1)
    @comment3 = Comment.create(text: 'How come, G?', author: @cr7, post: @messi_post1)
    @comment4 = Comment.create(text: 'I miss Iniesta and xavi, G!', author: @messi, post: @messi_post1)
    @comment5 = Comment.create(text: 'I miss Ramos and Marcelo, G!', author: @cr7, post: @messi_post1)
    @comment6 = Comment.create(text: 'I miss the old days, G!', author: @messi, post: @messi_post1)
    @comment7 = Comment.create(text: 'I miss the old days too, G!', author: @cr7, post: @messi_post1)
  end

  describe 'index page' do
    before(:example) do
      visit user_posts_path(@messi)
    end

    it 'should render posts author information' do
      expect(page).to have_css("img[src*='/assets/default_user.png']")
      expect(page).to have_content(@messi.name)
      expect(page).to have_content("Posts: #{@messi.postsCounter}")
    end

    it 'should render user posts information' do
      @messi.posts.each do |post|
        expect(page).to have_content(post.title.capitalize)
        expect(page).to have_content(post.text.truncate(100))
        expect(page).to_not have_content("Comments: #{post.comments_counter} | Likes: #{post.likes_counter}")
      end

      # five recent comments on the post
      @messi_post1.most_recent_five_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'should redirect to post show page when clicking on post title' do
      click_link @messi_post1.title.capitalize
      expect(page).to have_current_path(user_post_path(@messi, @messi_post1))
    end
  end
end