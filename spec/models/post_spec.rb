require 'rails_helper'

RSpec.describe Post, type: :model do
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
