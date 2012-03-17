class Discussion < ActiveRecord::Base
  belongs_to :course

  def self.active
    where(:archived => false)
  end
  
  def self.inactive
    where(:archived => true)
  end
  
  def self.conversations
    where(:category => "conversation")
  end

  def self.reviews
    where(:category => "review")
  end

  def self.evaluations
    where(:category => "evaluation")
  end
end
