class ItemsController < ApplicationController
  respond_to :json

  def random
    @item = Item.random
    respond_with @item
  end

  def show
    @item = Item.where(uuid: params[:id]).first
    respond_with @item
  end


end
