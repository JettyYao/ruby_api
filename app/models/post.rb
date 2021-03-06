class Post < ApplicationRecord
  belongs_to :tag
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :author, :content
end
