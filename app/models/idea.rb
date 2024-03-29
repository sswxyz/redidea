# == Schema Information
#
# Table name: ideas
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Idea < ActiveRecord::Base
  validates :content, :presence     => true,
                      :length       => { :within => 6..400 }
  validates :title,   :presence     => true,
                      :uniqueness   => true,
                      :length       => { :maximum => 30 }
  validates :user_id, :presence => true

  belongs_to :user 
  attr_accessible :title, :created_at, :content

end
