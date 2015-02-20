class CreateContact < ActiveRecord::Migration
  def change
    create_table :spree_contacts do |t|
      t.string :email
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
