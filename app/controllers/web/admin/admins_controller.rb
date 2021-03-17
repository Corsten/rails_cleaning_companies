class Web::Admin::AdminsController < Web::Admin::ApplicationController
  def index
    @admins = Admin.all.page(params[:page])
    authorize current_user
  end

  def new
    @admin = Admin.new
    authorize current_user
  end

  def create
    @admin = Admin.new(admins_attrs)
    authorize current_user
    if @admin.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    @admin = Admin.find(params[:id])
    authorize @admin
  end

  def edit
    @admin = Admin.find(params[:id])
    authorize @admin
  end

  def update
    @admin = Admin.find(params[:id])
    authorize @admin
    if @admin.update(admins_attrs)
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def del
    admin = Admin.find(params[:admin_id])
    authorize admin
    admin.del
    redirect_to action: :index
  end

  def restore
    admin = Admin.find(params[:admin_id])
    authorize admin
    admin.activate
    redirect_to action: :index
  end

  private

  def admins_attrs
    params.require(:admin).permit(:name, :surname, :patronymic, :email, :password, :role)
  end
end
