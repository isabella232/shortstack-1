class Person < ActiveRecord::Base
  default_scope order("name ASC")  
  has_many :contributions, :as => :contributable, :class_name => "Contribution"
  has_many :notes, :as => :noteable, :class_name => "Note"
  has_many :links, :as => :linkable, :class_name => "Link"
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :notes  
  after_create :create_contribution
  after_update :update_contribution  
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end
  
  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
end
