class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page])
  end
  
  def order_search
    @order_status = params[:order_status]
    if @order_status.blank?
      @orders = Order.page(params[:page])
      render "admin/homes/top"
    else
      @orders = Order.looks(params[:order_status]).page(params[:page])
      render "admin/homes/top"
    end
  end

end
