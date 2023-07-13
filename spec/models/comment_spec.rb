require 'rails_helper'

RSpec.describe Comment, type: :model do
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
