class AddFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_url, :string
    add_column :movies, :poster_url, :string
  end
end
