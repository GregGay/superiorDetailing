class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :package
      t.string :package2
      t.string :package3
      t.string :package4
      t.string :package5
      t.string :package6
      t.string :package7
      t.string :package8
      t.string :package9
      t.string :package10
      t.string :date
      t.string :date2
      t.string :date3
      t.string :date4
      t.string :date5
      t.string :date6
      t.string :date7
      t.string :date8
      t.string :date9
      t.string :date10
      t.integer :user_id

      t.timestamps
    end
    add_index :appointments, [:user_id, :created_at]
  end
end
