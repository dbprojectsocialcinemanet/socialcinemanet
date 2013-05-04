class InfoController < ApplicationController
  
  def index
    # @movies = Movie.where('id > ? AND imdb_rating > 0', 50000).find(:all, :limit => 20)
    
    @sort_by = params[:sort_by] || 'name'
    
    if @sort_by == 'imdb_rating'
      movie_count = Movie.where("name <> '' AND name IS NOT null AND imdb_rating IS NOT null").count
    else
      movie_count = Movie.where("name <> '' AND name IS NOT null").count
    end
    @max_pages = movie_count / 20
    
    @idx = params[:idx].to_i
    @idx = @idx <= 0 ? 1 : @idx
    @idx_prev = @idx <= 1 ? nil : @idx-1
    @idx_next = @idx >= @max_pages ? nil : @idx+1
    
    if @idx <= 3 
      @page_nums = [ 1, 2, 3, 4, 5]
    elsif @idx >= @max_pages - 2
      @page_nums = [ @max_pages-4, @max_pages-3, @max_pages-2, @max_pages-1, @max_pages]
    else
      @page_nums = [ @idx - 2, @idx - 1, @idx, @idx + 1, @idx + 2]
    end
    
   @movies = Movie.movie_tables(@idx, @sort_by)
  end
  
  def search
    
    @search_val = params[:search_val] ? params[:search_val].gsub(/[^0-9a-z ]/i, '') : nil
    
    if @search_val and @search_val.strip!=""
      @movie_result = Info.search_movies(@search_val)
      @genre_result = Info.search_genres(@search_val)
      @person_result = Info.search_persons(@search_val)
      @oscar_result = Info.search_oscars(@search_val)
    else
      @movie_result = []
      @genre_result = []
      @person_result = []
      @oscar_result = []
    end
    
    
    
  end
  
  def advanced_search 
    
  end
  
  def rate_it
    while (@movie = Movie.where("name is not null and name <> ''").offset(rand(Movie.count)).first) == nil
      next
    end
    # /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)\s\((.+)\)/ =~ @movie.name
    # movie_name = $1 || @movie.name
    # # @movie = Movie.find 279154
    # @imdb_url = nil
    # @imdb_poster = nil
    # imdb_id = nil
    # cnt = 0
    # imdb_search = Imdb::Search.new(movie_name).movies.each do |movie|
    #   /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)\s\((\d\d\d\d)\)/ =~ movie.title
    #   if $1 == movie_name && $3.to_i == @movie.release_date.year
    #     @imdb_url = movie.url
    #     @imdb_poster = movie.poster
    #     @movie.imdb_rating = movie.rating
    #     @movie.save
    #     break
    #   end
    #   cnt += 1
    #   if cnt > 5 then break end
    # end
  end
  
  def ajax_imdb_update
    imdb_url = params[:imdb_url]
    movie = Movie.find params[:id]
    
    /tt(\d+)/ =~ imdb_url
    if !$1
      @imdb_url_not_found = true
    else 
      imdb_movie = Imdb::Movie.new($1)
      if !imdb_movie
        @imdb_url_not_found = true
      else
        movie.imdb_url = imdb_url
        movie.poster_url = imdb_movie.poster
        movie.imdb_rating = imdb_movie.rating
        movie.release_date = DateTime.strptime(imdb_movie.year.to_s, "%Y")
        movie.save
      end
    end
    # return render :text => imdb_url
    render :partial => 'movies/movie', :locals => {:movie => movie}
  end

end