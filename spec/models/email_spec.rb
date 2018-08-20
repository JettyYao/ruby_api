require 'rails_helper'

RSpec.describe Email, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:content) }
end
