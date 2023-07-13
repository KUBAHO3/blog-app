require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) { described_class.new(user:, post:) }
  let(:user) { User.create(Name: 'John Doe') }
  let(:post) { Post.create(Title: 'Lorem ipsum', CommentsCounter: 0, LikesCounter: 0, user:) }

  before { like.save }

  describe 'associations' do
    it 'belongs to a user' do
      expect(like.user).to eq(user)
    end

    it 'belongs to a post' do
      expect(like.post).to eq(post)
    end
  end

  describe 'callbacks' do
    it "increments the post's likes counter after saving" do
      expect(post.LikesCounter).to eq(1)
    end
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
