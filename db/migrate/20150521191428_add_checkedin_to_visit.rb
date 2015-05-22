class AddCheckedinToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :checkedin, :boolean, :default => false
  end
end
