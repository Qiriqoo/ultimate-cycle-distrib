class CreatePartner < ActiveRecord::Migration
  def change
    create_table :spree_partners do |t|
      t.string :name
      t.attachment :logo
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
