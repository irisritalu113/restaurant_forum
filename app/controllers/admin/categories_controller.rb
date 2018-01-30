class Admin::CategoriesController < ApplicationController
  
  
  
  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      #如果儲存成功，讓使用者繼續瀏覽資料
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    
    else
      # 重新 render index 樣板，需要再額外傳入 index 需要的 @categories 實例變數
      @categories = Category.all
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was successfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to admin_categories_path
  end


  private
  # 使用 Strong parameter 來允許表單傳入資料
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end