class ReportWorker < ApplicationWorker
  def perform(report_id, params)
    report = Report.find(report_id)

    file_path = Rails.root.join('storage/')
    file_name = "#{params['kind']}_#{report.created_at}.#{params['type']}"

    data_report = Reports::BaseReport.new.export(params['kind'], params['q'])
    File.open("#{file_path}#{file_name}", 'w') { |file| file.puts data_report }

    report.file_path = file_path
    report.file_name = file_name
    report.finish!
  end
end
