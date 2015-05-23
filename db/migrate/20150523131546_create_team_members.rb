class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :slack_name
      t.string :image_path

      t.timestamps null: false
    end
  end
end
