class AddActiveToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :active, :boolean, default: false
  end
end
