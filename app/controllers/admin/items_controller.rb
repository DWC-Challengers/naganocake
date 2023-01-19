class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
    if @item.save
      redirect_to admin_item_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end
  
end
