class MoviesController < ApplicationController
  def index
    @movies = Movies.all?
  end

  def show
    @movie = Movies.find(params[:id])
  end

  def new
    @movies = Movies.new
  end

  def edit
    @movie = Movies.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    @movie = Movies.find(params[:id])
    
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description)
  end

end
