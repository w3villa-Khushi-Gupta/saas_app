class CreateUserTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tenants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_tenants, [:user_id, :tenant_id], unique: true
  end
end
