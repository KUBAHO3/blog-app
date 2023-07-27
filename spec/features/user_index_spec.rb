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

  describe 'index page' do
    before(:example) do
      visit users_path
    end

    it 'should render user information' do
      expect(page).to have_content(@cristiano.name)
      expect(page).to have_content(@john.name)

      expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
      expect(page).to have_css("img[src*='default_user.png']")

      expect(page).to have_content(@cristiano.postsCounter)
      expect(page).to have_content(@john.postsCounter)
    end

    it 'should redirect to the user page when a username is clicked' do
      find('.user_card', text: @john.name).click
      expect(page).to have_current_path(user_path(@john))
    end
  end
end
