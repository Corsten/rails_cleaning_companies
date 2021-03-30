class Web::Admin::ClientsController < Web::Admin::ApplicationController
  def index
    @search = Client.ransack(params[:q])
    @search_params = params.permit!.slice(:q).to_h
    @clients = @search.result.page(params[:page])
    authorize current_admin, policy_class: AdminPolicy
  end

  def new
    @client = Client.new
    authorize current_admin, policy_class: AdminPolicy
  end

  def create
    @client = Client.new(client_attrs)
    authorize current_admin, policy_class: AdminPolicy
    if @client.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    @client = Client.find(params[:id])
    authorize @client
  end

  def edit
    @client = Client.find(params[:id])
    authorize @client
  end

  def update
    @client = Client.find(params[:id])
    authorize @client
    if @client.update(client_attrs)
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def del
    client = Client.find(params[:client_id])
    authorize current_admin, policy_class: AdminPolicy
    client.del

    redirect_to action: :index
  end

  def restore
    client = Client.find(params[:client_id])
    authorize current_admin, policy_class: AdminPolicy
    client.activate

    redirect_to action: :index
  end

  def export
    report = Report.new(admin_id: current_admin.id, file_type: params['type'])
    report.start
    ReportWorker.perform_async(report.id, params.as_json)

    redirect_to admin_reports_path
  end

  private

  def client_attrs
    params.require(:client).permit(:name, :surname, :email, :phone_number, :password)
  end
end
