class MoviesController < ApplicationController

  def index 
  end

  def results
    @query = params[:query]

    request = Typhoeus.get(
      "http://www.omdbapi.com",
      :params => {:s => @query}
      )
    @results = JSON.parse(request.body)
  end

  def show
    @movie = params[:id]

    request = Typhoeus.get(
      "http://www.omdbapi.com",
      :params => {:i => @movie}
      )
    @movie_results = JSON.parse(request.body)
    @flag = 0
    if (Movie.find_by_imdbID "#{@movie}") != nil
      mov = Movie.find_by_imdbID "#{@movie}"
      case mov.rating
        when 1 then @flag=1
        when 2 then @flag=2
        when 3 then @flag=3
        when 4 then @flag=4
        when 5 then @flag=5
      end
    end
  end

  def update
    @movie = params[:id]
    request = Typhoeus.get(
      "http://www.omdbapi.com",
      :params => {:i => @movie}
      )
    @movie_results = JSON.parse(request.body)

    mov = Movie.find_by_imdbID "#{@movie}"
    if mov != nil
      mov.update_attributes(rating: "#{params[:rad]}")
    else
      Movie.create(imdbID: "#{params[:id]}",title: "#{@movie_results['Title']}", rating: "#{params[:rad]}" )
    end
    redirect_to "/movies/#{params[:id]}"
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

end
