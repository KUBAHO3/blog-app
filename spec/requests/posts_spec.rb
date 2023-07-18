require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET' do
    before :all do
      @user1 = User.create(name: 'Linne Kubaho', photo: 'https://myphotos.com', bio: 'I am a full-stack web developer')
    end

    describe '/posts#index' do
      before :each do
        get user_posts_path(@user1)
      end

      it 'status was correct' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index correct template was rendered' do
        expect(response).to render_template(:index)
      end

      it 'should include the correct placeholder text' do
        expect(response.body).to include('Hello List of posts will appear right here')
      end
    end

    describe '/posts#show' do
      before :each do
        @post1 = Post.create(title: 'The Streak', text: 'The Streak is over!', author: @user1)
        get user_post_path(@user1, @post1)
      end

      it 'should return a correct successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index correct template was rendered' do
        expect(response).to render_template(:show)
      end

      it 'should include the correct placeholder text' do
        expect(response.body).to include('Hello Selected post detail will appear right here')
      end
    end
  end
end
