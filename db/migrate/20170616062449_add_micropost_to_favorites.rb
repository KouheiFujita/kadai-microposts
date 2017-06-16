class AddMicropostToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorites, :micropost, foreign_key: true
  end
end
