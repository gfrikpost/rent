class Userpost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  default_scope :order => 'userposts.created_at DESC'
end
