require 'rails_helper'

RSpec.describe Reply, type: :model do
  it { should belong_to(:comment) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:content) }
end
