class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.float :total

      t.timestamps
    end
  end
end
