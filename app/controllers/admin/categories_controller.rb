class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @categories = Category.all
    @category = Category.new
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

  private
  # 使用 Strong parameter 來允許表單傳入資料
  def category_params
    params.require(:category).permit(:name)
  end

end