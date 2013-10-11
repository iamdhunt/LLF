class Activity < ActiveRecord::Base
  belongs_to :member
  belongs_to :targetable, polymorphic: true
end
