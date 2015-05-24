class AddPhoneIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_id, :string
  end
end
