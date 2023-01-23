class Public::SearchesController < ApplicationController
before_action :authenticate_customer!
    
  def search
      @items = Item.looks(params[:word]).page(params[:page])
      render "public/searches/search_result"
  end
end
