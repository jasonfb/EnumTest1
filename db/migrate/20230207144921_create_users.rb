class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :user_status, ["pending", "active", "archived"]

    create_table :users, force: true do |t|
      t.enum :status, enum_type: "user_status", default: "pending", null: false
      t.timestamps
    end
  end
end
