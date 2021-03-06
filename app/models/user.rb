class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :view_as_user, :role

  has_one :member

  before_create :build_default_member
  before_update :confirm_password
  after_destroy :desactivate_member

  scope :new_comers, self.where(['members.is_active = ?', true]).order('created_at DESC').limit(6).includes(:member)
  scope :new_outers, self.where(['members.is_active = ?', false]).order('created_at DESC').limit(6).includes(:member)

private
  def build_default_member
    build_member
    true
  end

  def confirm_password
    (self.password == self.password_confirmation) ? true : false
  end
  
  def desactivate_member
    member = Member.where(:user_id => self.id).first
    member.update_attributes(:is_active => false)
  end

end

