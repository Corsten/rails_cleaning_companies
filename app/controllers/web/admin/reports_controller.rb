class Web::Admin::ReportsController < Web::Admin::ApplicationController
  def index
    query = { s: 'id desc' }.merge(filter_params[:q] || {})
    @search = Report.ransack(query)
    @reports = @search.result.page(filter_params[:page])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_attrs)
    @report.admin = current_admin
    redirect_to report: :index
  end

  def destroy
    report = Report.find(params[:id])
    report.file.purge
    report.delete
    redirect_to admin_reports_path
  end

  private

  def filter_params
    params.permit!
  end

  def report_attrs
    params.permit(:id, :state, :kind, :file_type, :file)
  end
end
