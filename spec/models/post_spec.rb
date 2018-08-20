require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:tag) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:content) }
end
