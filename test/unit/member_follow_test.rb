require 'test_helper'

class MemberFollowTest < ActiveSupport::TestCase
	should belong_to(:member)
	should belong_to(:follow)

	test "that creating a follow works without raising an exception" do
		assert_nothing_raised do  
			MemberFollow.create member: members(:dario), follow: members(:gary)
		end 
	end 

	test "that creating a follow relationship works using member id and follow id" do 
    	MemberFollow.create member_id: members(:dario).id, follow_id: members(:mike).id
    	assert members(:dario).follows.include?(members(:mike))
  	end 

end
