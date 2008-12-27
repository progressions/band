class CreateShowReports < ActiveRecord::Migration
  def self.up
    create_table :show_reports do |t|
      t.integer :show_id
      t.text :notes
      t.integer :attendance
      t.integer :yes_rsvps
      t.integer :maybe_rsvps
      t.integer :no_rsvps
      t.integer :fliers_distributed
      t.integer :posters_distributed
      t.integer :cds_distributed
      t.integer :merchandise_distributed

      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :show_reports
  end
end
