class RenameReportColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :reports, :type, :file_type
    rename_column :reports, :file_name, :file
  end
end
