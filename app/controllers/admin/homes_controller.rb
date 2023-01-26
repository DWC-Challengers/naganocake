class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_customer_login
  

  def top
    @orders = Order.page(params[:page])
  end
  
  def order_search
    @order_status = params[:order_status]
    @orders = Order.looks(params[:order_status]).page(params[:page])
    render "admin/homes/top"
  end
  
private

  def check_customer_login
    if customer_signed_in? && admin_signed_in?
      sign_out(:customer)
    end 
  end

end
