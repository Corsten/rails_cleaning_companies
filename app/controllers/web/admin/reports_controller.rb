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
    if @report.save
      redirect_to report: :index
    else
      render report: :new
    end
  end

  def download
    send_file params[:file_path]
  end

  private

  def filter_params
    params.permit!
  end

  def report_attrs
    params.require(:report).permit(:state, :kind, :file_type, :file_name)
  end
end
