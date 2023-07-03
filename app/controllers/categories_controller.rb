class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category created successfully.'
    else
      flash.now[:error] = 'Category already exists.' if category_already_exists?
      render :new
    end
  end
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category_already_exists?
    Category.exists?(name: @category.name)
  end
end
