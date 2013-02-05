class Userpost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 65535 }
  validates :user_id, :presence => true
  
  default_scope :order => 'userposts.created_at DESC'
end
