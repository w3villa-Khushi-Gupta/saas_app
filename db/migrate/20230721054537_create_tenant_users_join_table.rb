class CreateTenantUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tenants, :users do |t|
      t.index [:tenant_id, :user_id]
    end
  end
end
