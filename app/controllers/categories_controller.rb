class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(catetory_params)

    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by slug: params[:id]
  end

  private

  def catetory_params
    params.require(:category).permit(:category)
  end
end