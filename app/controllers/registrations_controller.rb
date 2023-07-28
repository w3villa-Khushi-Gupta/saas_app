# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
    def create
      build_resource(sign_up_params)
      # Save the User object first
      resource.save
      # If the user was saved successfully, create the associated Tenant and save it
      if resource.persisted?

        tenant_params = params[:tenant]
        tenant = Tenant.new(name: tenant_params[:name], plan: tenant_params[:plan])
        tenant.save

        # Associate the User with the Tenant
        UserTenant.create(user: resource, tenant: tenant)  
        # Save the Tenant object to create the association between User and Tenant
      end
    end
  
    private

    # Strong parameters for User and nested Tenant attributes
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def tenant_params
      params.require(:tenant).permit(:name) # Add other tenant attributes as needed
    end

end
  