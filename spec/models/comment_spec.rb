require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { described_class.new(user:, post:, Text: 'Lorem ipsum') }
  let(:user) { User.create(Name: 'John Doe') }
  let(:post) { Post.create(Title: 'Lorem ipsum', CommentsCounter: 0, LikesCounter: 0, user:) }

  before { comment.save }

  describe 'associations' do
    it 'belongs to a user' do
      expect(comment.user).to eq(user)
    end

    it 'belongs to a post' do
      expect(comment.post).to eq(post)
    end
  end

  describe 'callbacks' do
    it "increments the post's comments counter after saving" do
      expect(post.CommentsCounter).to eq(1)
    end
  end

  it 'Text is present' do
    subject.Text = nil
    expect(subject).to_not be_valid
  end
  it 'Text is less than or equal to 250' do
    subject.Text = 'a' * 251
    expect(subject).to_not be_valid
  end
  it 'AuthorId is present' do
    subject.AuthorId = nil
    expect(subject).to_not be_valid
  end
  it 'PostId is present' do
    subject.PostId = nil
    expect(subject).to_not be_valid
  end
end
