class CreateExports < ActiveRecord::Migration
  def change
    create_table :spree_exports do |t|
      t.integer :source
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
