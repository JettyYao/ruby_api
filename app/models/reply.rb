class Reply < ApplicationRecord
  belongs_to :comment
  validates_presence_of :username, :account, :content
end
