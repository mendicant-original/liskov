class Discussion < ActiveRecord::Base
  belongs_to :course

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
