require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
    before :all do
      @user1 = User.create(name: 'Linne Heaven', photo: 'https://myphoto.com',
                           bio: 'I am a full-stack software developer')
      @post1 = Post.create(title: 'My present', text: 'It can be found in there', author: @user1)
    end

    describe '/users#index' do
      before :each do
        get users_path
      end

      it 'should return a correct successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index correct template was rendered' do
        expect(response).to render_template(:index)
      end

      it 'should include the correct placeholder text' do
        expect(response.body).to include(@user1.name)
      end
    end

    describe '/users#show' do
      before :each do
        get user_path(@user1)
      end

      it 'should return a correct successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index correct template was rendered' do
        expect(response).to render_template(:show)
      end

      it 'should include the correct placeholder text' do
        expect(response.body).to include(@post1.title)
      end
    end
  end
end
