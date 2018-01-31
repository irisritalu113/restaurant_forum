class RestaurantsController < ApplicationController
  
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  
  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  # GET restaurants/feeds
  # 會去 render app/views/restuarants/feeds.html.erb
  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants/:id/favorite
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.count_favorites
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  # POST /restaurants/:id/unfavorite
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    # 由於 favorites 只在 Action 內部使用，所以單純用區域變數 (local variable) 的命名方法，而沒有特別宣告成實例變數 (instance variable)。這是屬於撰寫程式碼的 style，在這裡，即使寫成實例變數，也不會影響功能的執行。
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    @restaurant.count_favorites
    redirect_back(fallback_location: root_path)
  end

  # GET /restaurants/ranking
  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

end
