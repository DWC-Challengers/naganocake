class Admin::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
    @item.is_active = true
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)
      redirect_to admin_item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :genre_id, :non_taxed_price, :is_active)
  end

end
