require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'AuthorId is present' do
    subject.AuthorId = nil
    expect(subject).to_not be_valid
  end

  it 'PostId is present' do
    subject.PostId = nil
    expect(subject).to_not be_valid
  end
end
