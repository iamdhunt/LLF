class Activity < ActiveRecord::Base
  belongs_to :member
  belongs_to :targetable, polymorphic: true
  acts_as_votable

  self.per_page = 36

  def self.for_member(member, options={})
  	options[:page] ||= 1
  	following_ids = member.following_members.map(&:id).push(member.id)
  	collection = where("member_id in (?)", following_ids).
  		order("created_at desc")
    if options[:since] && !options[:since].blank?
      since = DateTime.strptime( options[:since], '%s')
      collection = collection.where("created_at > ?", since) if since 
    end
  		collection.page(options[:page])
  end 

  
end
