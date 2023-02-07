class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :status, ["pending", "active", "archived"]

    create_table :users, force: true do |t|
      t.enum :status, enum_type: "status", default: "pending", null: false
      t.timestamps
    end
  end
end
