class Admin::CustomersController < ApplicationController

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
      redirect_to admin_customer_path,success:"会員情報を更新しました"
    else
      flash.now[:danger] = "会員情報の更新に失敗しました"
      render :edit
      
    end
  end
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana,
    :last_name_kana,:email, :postal_code, :address, :phone_number, :is_deleted)
  end
  

end