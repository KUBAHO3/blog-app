require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'should validate that postsCounter is greater than or equal to 0' do
      user = User.new(name: 'John Doe', postsCounter: -1)
      expect(user).not_to be_valid
      expect(user.errors[:postsCounter]).to include('must be greater than or equal 0')
    end
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('author_id') }
  end

  describe 'most_recent_three_posts' do
    let(:user) { create(:user) }

    it 'should return the three most recent posts and no more' do
      user = User.create(name: 'name')
      old_post = Post.create(title: 'second post', text: 'text', author_id: user.id)
      first_post = Post.create(title: 'second post', text: 'text', author_id: user.id)
      second_post = Post.create(title: 'third post', text: 'text', author_id: user.id)
      third_post = Post.create(title: 'fourth post', text: 'text', author_id: user.id)
      expect(user.most_recent_three_posts).to include(first_post)
      expect(user.most_recent_three_posts).to include(second_post)
      expect(user.most_recent_three_posts).to include(third_post)
      expect(user.most_recent_three_posts).to_not include(old_post)
    end
  end
end
