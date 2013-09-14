require 'test_helper'

class MemberTest < ActiveSupport::TestCase
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

  test "a member should should have a username without spaces" do 
  	member = Member.new
  	member.user_name = "My username with spaces"

  	assert !member.save
  	assert !member.errors[:user_name].empty?
  	assert member.errors[:user_name].include?("Must be formatted correctly.")
  end

end
