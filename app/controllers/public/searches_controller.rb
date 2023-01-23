class SearchesController < ApplicationController
before_action :authenticate_customer!
    
  def search
      @items = Item.looks(params[:word])
      render "/searches/search_result"
  end
end
