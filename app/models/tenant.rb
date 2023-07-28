class Tenant < ApplicationRecord
    # acts_as_universal_and_determines_tenant
    # has_many :user_tenants
    has_many :users, through: :members
    has_many :members, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_one :payment
    accepts_nested_attributes_for :payment
    validates_uniqueness_of :name
    validates_presence_of :name

    def can_create_projects?
        (plan == 'free' && projects.count < 1) || (plan == 'premium')
    end

    def self.create_new_tenant(tenant_params, user_params)
        tenant = Tenant.new(tenant_params)
        if @tenant.save
            redirect_to tenant_path(@tenant), notice: "Tenant was successfully created."
        else
            # Handle validation errors or other issues
            render :new
        end
    end
  
    def self.new_signups_not_permitted?(params)
        return false
    end

    def self.tenant_signup(user, tenant, other = nil)
        #  StartupJob.queue_startup( tenant, user, other )
        # any special seeding required for a new organizational tenant
        #
        Member.create_org_admin(user)
        #
      end
end
