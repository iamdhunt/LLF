class Status < ActiveRecord::Base
  attr_accessible :content, :member_id
  belongs_to :member 
end
