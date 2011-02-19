class Statistic < ActiveRecord::Base
  default_scope order('created_at ASC')
  belongs_to :statistic_type
  belongs_to :statisticable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  after_update :update_contribution
  after_create :create_contribution

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
end
