class Tag < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates_presence_of :tag_name, :created_by
end
