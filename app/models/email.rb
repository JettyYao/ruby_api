class Email < ApplicationRecord
    validates_presence_of :username, :account, :content
end
