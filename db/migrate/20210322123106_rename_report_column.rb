class RenameReportColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :reports, :type, :file_type
  end
end
