class AddUserIdToVisits < ActiveRecord::Migration
  def change
    add_reference :visits, :user, index: true, foreign_key: true
  end
end
