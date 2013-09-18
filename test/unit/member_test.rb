require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  should have_many(:member_follows)
  should have_many(:follows)

  test "a member should enter a first name" do 
  	member = Member.new
  	assert !member.save
  	assert !member.errors[:first_name].empty? 	
  end

  test "a member should enter a last name" do 
  	member = Member.new
  	assert !member.save
  	assert !member.errors[:last_name].empty?
  end

  test "a member should enter a username" do 
  	member = Member.new
  	assert !member.save
  	assert !member.errors[:user_name].empty?
  end

  test "a member should should have a username" do 
  	member = Member.new
  	assert !member.save
  	assert !member.errors[:user_name].empty?
  end

  test "that no error is raised when trying to access a follow list" do 
    assert_nothing_raised do 
      members(:dario).follows
    end 
  end 

  test "that creating a follow relationship works" do 
    members(:dario).follows << members(:mike)
    members(:dario).follows.reload
    assert members(:dario).follows.include?(members(:mike))
  end 

end
