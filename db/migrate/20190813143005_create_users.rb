class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fs_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :country
      t.integer :zipcode

      t.timestamps
    end
  end
end
