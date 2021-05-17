class ListController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new()
  end

  def create
  end

  private

  def list_params
    params.require(:list).permit()
  end
end
