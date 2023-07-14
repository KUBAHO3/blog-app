require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name and non-negative post counter' do
      user = User.new(Name: 'John Doe', PostsCounter: 0)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(Name: nil, PostsCounter: 0)
      expect(user).not_to be_valid
    end

    it 'is invalid with a negative post counter' do
      user = User.new(Name: 'John Doe', PostsCounter: -1)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      association = User.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many comments' do
      association = User.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many likes' do
      association = User.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'recent_post' do
    let(:user) { User.create(Name: 'John Doe', PostsCounter: 0) }

    it 'returns the most recent posts in descending order' do
      post1 = user.posts.create(Title: 'First post', Text: 'Lorem ipsum')
      post2 = user.posts.create(Title: 'Second post', Text: 'Dolor sit amet')
      post3 = user.posts.create(Title: 'Third post', Text: 'Consectetur adipiscing elit')

      expect(user.recent_post).to eq([post3, post2, post1])
    end

    it 'returns no more than 3 posts' do
      4.times { |n| user.posts.create(Title: "Post #{n}", Text: 'Lorem ipsum') }

      expect(user.recent_post.size).to eq(3)
    end
  end

  subject { User.create(Name: 'Heaven', Photo: 'https://images.unsplash.com/photo-1621591557805-db1dc862a71c', Bio: 'Student at KLU.') }
  before { subject.save }

  it 'name is present' do
    subject.Name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter is greater than or equal to 0' do
    subject.PostsCounter = -1
    expect(subject).to_not be_valid
  end
end
