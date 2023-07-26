require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  before(:all) do
    @john = User.create(name: 'John Cena', photo: 'https://picsum.photos/200/300',
                        bio: 'Welcome to the new era of the WWE. The champ is here!')
    @cristiano = User.create(name: 'Cristiano Ronaldo', photo: '/assets/default_user.png',
                             bio: 'I am ubleivable inside the pitch.')

    @post1 = Post.create(title: 'I am the champ', text: 'I am the champ of the WWE.', author: @john)
    @post2 = Post.create(title: 'You can\'t see me', text: 'My time is now. It\'s the frenchise.', author: @john)
    @post3 = Post.create(title: 'I will never give up', text: 'I will never give up. I will never surrender.',
                         author: @john)
    @post4 = Post.create(title: 'No one can beat me', text: 'No one can beat me. I am the best.', author: @john)
    @post5 = Post.create(title: 'Like it or not', text: 'Like it or not, I am the best.', author: @john)
  end


    it 'shows the user profile information' do
      expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
      expect(page).to have_content(@john.name)
      expect(page).to have_content("Posts: #{@john.postsCounter}")
      expect(page).to have_content(@john.bio)

      # shows the user's 3 most recent posts
      @john.most_recent_three_posts.each do |post|
        expect(page).to have_content(post.title.capitalize)
        expect(page).to have_content(post.text)
      end

      # shows a button to view all posts
      expect(page).to have_link('See all posts', href: user_posts_path(@john))
    end

    it 'redirects to post show page when clicking on a post title' do
      click_link @post5.title.capitalize
      expect(page).to have_current_path(user_post_path(@john, @post5))
    end

    it 'redirects to user posts index page when clicking on view all posts button' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@john))
    end
  end
end
