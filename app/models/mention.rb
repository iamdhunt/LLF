class Mention < ActiveRecord::Base
	belongs_to :status
	belongs_to :mentionable, polymorphic: true
end
