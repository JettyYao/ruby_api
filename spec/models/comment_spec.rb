require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:post) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:content) }
end
