class Mention < ActiveRecord::Base
	attr_accessible :status_id, :comment_id, :member_id, :mentionable_type, :mentionable_id

    belongs_to :mentionable, polymorphic: true
end