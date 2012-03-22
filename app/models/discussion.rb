class Discussion < ActiveRecord::Base  
  VALID_CATEGORIES = ["conversations", "reviews", "evaluations"]

  belongs_to :course
  
  def self.search(params)
    results = params["state"] =="closed" ? inactive : active
    
    category = params["category"]
    
    if VALID_CATEGORIES.include?(category)
      results.send(category)
    else
      results.conversations 
    end
  end
  
  def self.active
    where(:archived => false)
  end
  
  def self.inactive
    where(:archived => true)
  end
  
  def self.conversations
    where(:category => "conversations")
  end

  def self.reviews
    where(:category => "reviews")
  end

  def self.evaluations
    where(:category => "evaluations")
  end
end
