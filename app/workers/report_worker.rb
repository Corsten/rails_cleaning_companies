class ReportWorker < ApplicationWorker
  def perform(report_id, params)
    report = Report.find(report_id)

    data_report = Reports::BaseReport.new.export(params['kind'], params['q'])
    report.file.attach(io: StringIO.new(data_report),
                       filename: "#{params['kind']}_#{report.created_at}.#{params['type']}")

    report.finish!
  end
end
