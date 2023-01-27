class Admin::SearchesController < ApplicationController
   
  def search
    @range = params[:range]
    if @range == "Customer"
      @customers = Customer.looks(params[:word]).page(params[:page])
      render "admin/searches/search_result"
    else
      @items = Item.looks(params[:word]).page(params[:page])
      render "admin/searches/search_result"
    end
  end
  
end
