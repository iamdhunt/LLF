class Activity < ActiveRecord::Base
  belongs_to :member
  belongs_to :targetable, polymorphic: true
  acts_as_votable

  self.per_page = 36

  def self.for_member(member, options={})
  	options[:page] ||= 1
  	following_ids = member.following_members.map(&:id).push(member.id)
  	where("member_id in (?)", following_ids).
  		order("created_at desc").
  		page(options[:page])
  end 
end
