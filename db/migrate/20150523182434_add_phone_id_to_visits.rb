class AddPhoneIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :phone_id, :string
  end
end
