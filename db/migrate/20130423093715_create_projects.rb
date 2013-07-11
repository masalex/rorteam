class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, limit: 255
      t.text :description
      t.date :since
      t.integer :team_size

      t.timestamps
    end
  end
end
