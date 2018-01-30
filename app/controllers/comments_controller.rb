class CommentsController < ApplicationController
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id]) #確認評論屬於哪一個@restaurant
    @comment = @restaurant.comments.build(comment_params) #建立屬於@restaurant的評論，評論內容來自表單傳入的資料
    @comment.user = current_user                          #關聯外鍵user.id
    @comment.save!                                        #將評論存入資料庫，與.save不同處在於不論驗證或錯誤都會送資料
    redirect_to restaurant_path(@restaurant)              #回到restaurants/show
  end

  private

  #要透過permit將允許的表單內容登記下來
  def comment_params
    params.require(:comment).permit(:content)
  end
end
