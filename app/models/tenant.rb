class Tenant < ApplicationRecord
    acts_as_universal_and_determines_tenant
    has_many :members, dependent: :destroy


    def self.create_new_tenant(tenant_params, user_params)

        tenant = Tenant.new(:name => tenant_params[:name])
        tenant.save    # create the tenant
        return tenant
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
