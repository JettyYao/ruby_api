class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies, dependent: :destroy
  validates_presence_of :username, :account, :content
end
