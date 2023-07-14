require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }

    it 'should validate that comments_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: -1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal 0')
    end

    it 'should validate that likes_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: 1, likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal 0')
    end

    it 'title should not exceed 250 characters' do
      mock_title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Sed ut tellus metus. Vivamus malesuada, purus sed venenatis rutrum, nunc ex
      viverra elit,
      ac bibendum orci turpis ut mi. Nulla facilisi. Fusce euismod, velit vel
      ultrices ullamcorper,
      nibh velit interdum leo, vel varius lacus sapien eu augue. Fusce euismod, velit
      vel ultrices ullamcorper, nibh velit
      interdum leo, vel varius lacus sapien eu augue. Sed eget nisl auctor, posuere enim eu,
      eleifend nisl. Mauris bibendum volutpat nunc ac interdum. Donec euismod, quam at
      elementum porttitor, odio neque consequat quam, nec lacinia nulla mi a ligula.
      Sed sed risus eget sapien scelerisque vehicula. Sed faucibus turpis et ante
      molestie, non gravida eros tincidunt. Nunc id urna diam. Fusce non est vel
      erat convallis tincidunt. Nulla facilisi. Donec id volutpat nulla.'
      post = Post.new(title: mock_title, comments_counter: 1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('cannot exceed 250 characters')
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).with_foreign_key('post_id') }
    it { should have_many(:likes).with_foreign_key('post_id') }
  end

  describe 'most_recent_five_comments' do
    let(:user) { create(:user) }

    it 'should return the three most recent posts and no more' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      old_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      first_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      second_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      third_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      fourth_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      fifth_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')

      expect(post.most_recent_five_comments).to include(first_comment)
      expect(post.most_recent_five_comments).to include(second_comment)
      expect(post.most_recent_five_comments).to include(third_comment)
      expect(post.most_recent_five_comments).to include(fourth_comment)
      expect(post.most_recent_five_comments).to include(fifth_comment)
      expect(post.most_recent_five_comments).to_not include(old_comment)
    end
  end
end
