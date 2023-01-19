class Public::ItemsController < ApplicationController
    
    
def index
  @items=Item.page(params[:page]).per(8)
end

def show
  @item=Item.find(params[:id]).per
end

private

  def items_params
    params.require(:items).permit(:name, :text, :non_taxed_price, :is_active)
  end

end
