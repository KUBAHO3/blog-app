require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end
end
