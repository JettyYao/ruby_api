require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:posts).dependent(:destroy) }
  it { should validate_presence_of(:tag_name) }
  it { should validate_presence_of(:created_by) }
end
