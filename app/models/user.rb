class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :validatable

        has_many :user_tenants
        has_many :tenants, through: :members
        has_many :tenants, through: :user_tenants      
        has_one :payment
        accepts_nested_attributes_for :payment
  def is_admin?
    is_admin
  end

  def save_and_invite_member
    status = nil
    if (self.email.blank?)
        self.errors.add(:email, :blank)
    elsif User.where([ "lower(email) = ?", self.email.downcase ]).present?
        self.errors.add(:email, :taken)
    else
        if self.password.blank?
            self.password = "password"
            self.password_confirmation = self.password
        else
            # if a password is being supplied, then ok to skip
            # setting up a password upon confirm
            self.skip_confirm_change_password = true #if ::Milia.use_invite_member
        end
        status = self.save && self.errors.empty?
    end
    return status
  end
  
         
end
