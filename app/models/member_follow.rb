class MemberFollow < ActiveRecord::Base
  belongs_to :member
  belongs_to :follow, class_name: 'Member', foreign_key: 'follow_id'

  attr_accessible :member, :follow, :member_id, :follow_id
end
