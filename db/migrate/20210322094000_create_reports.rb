class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :state, null: false
      t.string :file_name, null: true
      t.string :type, null: false
      t.string :file_path, null: true
      t.timestamps
    end
  end
end
