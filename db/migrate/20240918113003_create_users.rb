class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.text :description
      t.text :experience
      t.string :role

      t.timestamps
    end
  end
end
