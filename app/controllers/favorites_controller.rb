class FavoritesController < ApplicationController
  before_action :require_user_logged_in, :set_micropost
  
  def index
    if logged_in?
      @microposts = Micropost.all.order('created_at DESC').page(params[:page])
    end
  end
  
  def create
    @favorite = current_user.favorites.find_or_create_by(micropost_id: @micropost.id)
    if @favorite.save
      flash[:success] = 'お気に入りに登録しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    @favorite.destroy
    flash[:success] = 'お気に入りから削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :micropost_id)
  end

  def set_micropost
    @micropost = Micropost.find_by(id: params[:micropost_id])
  end
end

# <%= link_to 'Unfavorite', favorite_path(current_user.favorites.find_by(micropost_id: micropost.id)), method: :delete, class: 'btn btn-danger btn-xs' %>
# _favorite_button.html.erbの別パターン