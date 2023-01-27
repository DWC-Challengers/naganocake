class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @name = @customer.last_name + "　" + @customer.first_name
    @name_kana = @customer.last_name_kana + "　" + @customer.first_name_kana
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to admin_customer_path
    else
      flash.now[:danger] = "会員情報を正しく入力して下さい"
      @customer = Customer.find(params[:id])
      render :edit
      
    end
  
  end
  
  def customer_search
    @customers = Customer.looks(params[:customer_status]).page(params[:page])
    render "admin/customers/index"
  end
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana,
    :last_name_kana,:email, :postal_code, :address, :phone_number, :is_deleted)
  end
  

end