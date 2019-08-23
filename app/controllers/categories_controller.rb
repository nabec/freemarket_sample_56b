class CategoriesController < ApplicationController
  def search_children
    @categories = Category.where(parent_id: params[:select]).limit(18)
    respond_to do |format|
      format.json
    end
  end

  def index
  end
  
  def show
    @categories = Category.find(params[:id])
  end

end
