class AddPlanToTenants < ActiveRecord::Migration[7.0]
  def change
    add_column :tenants, :plan, :string
  end
end
