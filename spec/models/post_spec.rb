require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { described_class.new(Title: 'Lorem ipsum', CommentsCounter: 0, LikesCounter: 0, user:) }
  let(:user) { User.create(Name: 'John Doe') }

  describe 'validations' do
    it 'is valid with a Title, comments counter, likes counter, and user' do
      expect(post).to be_valid
    end

    it 'is not valid without a Title' do
      post.Title = nil
      expect(post).not_to be_valid
    end

    it 'is not valid with a Title longer than 250 characters' do
      post.Title = 'a' * 251
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative comments counter' do
      post.CommentsCounter = -1
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative likes counter' do
      post.LikesCounter = -1
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(post.user).to eq(user)
    end

    it 'has many comments' do
      expect(post.comments).to be_empty
    end

    it 'has many likes' do
      expect(post.likes).to be_empty
    end
  end

  describe '#recent_comments' do
    let(:post_with_comments) { Post.create(Title: 'Lorem ipsum', CommentsCounter: 0, LikesCounter: 0, user:) }

    it 'returns the most recent comments for the post' do
      comment1 = Comment.create(user:, post: post_with_comments, body: 'Comment 1')
      comment2 = Comment.create(user:, post: post_with_comments, body: 'Comment 2')
      comment3 = Comment.create(user:, post: post_with_comments, body: 'Comment 3')

      expect(post_with_comments.recent_comments).to eq([comment3, comment2, comment1])
    end

    it 'returns up to five comments' do
      Comment.create(user:, post: post_with_comments, body: 'Comment 1')
      comment2 = Comment.create(user:, post: post_with_comments, body: 'Comment 2')
      comment3 = Comment.create(user:, post: post_with_comments, body: 'Comment 3')
      comment4 = Comment.create(user:, post: post_with_comments, body: 'Comment 4')
      comment5 = Comment.create(user:, post: post_with_comments, body: 'Comment 5')
      comment6 = Comment.create(user:, post: post_with_comments, body: 'Comment 6')

      expect(post_with_comments.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end

  describe 'callbacks' do
    it "increments the user's posts counter after saving" do
      expect { post.save }.to change { user.reload.posts_counter }.by(1)
    end
  end

  subject { Post.create(Title: 'Title', Text: 'Text', AuthorId: 1) }
  before { subject.save }

  it 'Title is present' do
    subject.Title = nil
    expect(subject).to_not be_valid
  end
  it 'Text is present' do
    subject.Text = nil
    expect(subject).to_not be_valid
  end
  it 'AuthorId is present' do
    subject.AuthorId = nil
    expect(subject).to_not be_valid
  end
end
