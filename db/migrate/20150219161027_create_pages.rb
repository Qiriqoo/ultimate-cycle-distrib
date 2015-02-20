class CreatePages < ActiveRecord::Migration
  def change
    create_table :spree_pages do |t|
      t.string :name
      t.string :slug
      t.text :content
      t.timestamps
    end
  end
end
