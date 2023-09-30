class Member < ApplicationRecord

    belongs_to :user
    belongs_to :tenant

    validates :first_name, presence: true
    validates :last_name, presence: true
    

  

    # DEFAULT_ADMIN = {
  #   first_name: "Admin",
  #   last_name:  "Please edit me"
  # }

  # user = User.find_by(email:)

  # def self.create_new_member(user, params)
  #   # add any other initialization for a new member
  #   return user.create_member( params )
  # end

  # def self.create_org_admin(user)
  #   new_member = create_new_member(user, DEFAULT_ADMIN)
  #   unless new_member.errors.empty?
  #     raise ArgumentError, new_member.errors.full_messages.uniq.join(", ")
  #   end

  #   return new_member

  # end

end
