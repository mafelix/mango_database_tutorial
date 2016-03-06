class MoviesController < ApplicationController
  
  def show
    @movie = Movie.find(params[:id])
  end
  #gets attributes from form so you don't have to get the individual attribute of the form
  def new
    @movie = Movie.new
  end

  #Movie.where("name like ?",%adm%")
  def index
    if params[:search] == "" && params[:duration] == 'Select duration'
      @movies = Movie.all

    elsif params[:search] != ""
      @movies = Movie.titleordirector(params[:search])
      # Movie.where("title LIKE ? OR director LIKE ?", "%#{params[:search]}%","%#{params[:search]}%")

    elsif params[:duration] == 'Under 90 minutes'
      
      @movies = Movie.durationunder90

    elsif params[:duration] == 'Between 90 and 120 minutes'

      @movies = Movie.durationbetween
    #   where("runtime_in_minutes >= ? and runtime_in_minutes <= ?", 90, 120)
    # elsif params[:duration] == 'Over 120 minutes'

      @movies = Movie.durationover120
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  #creates the database entry with the params from new.
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    
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
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description)
  end

end
