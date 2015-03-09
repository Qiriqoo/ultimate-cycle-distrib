class AddReadToContact < ActiveRecord::Migration
  def change
    add_column :spree_contacts, :read, :boolean, default: false
  end
end
