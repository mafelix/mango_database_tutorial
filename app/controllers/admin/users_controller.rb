class Admin::UsersController <ApplicationController
before_filter :is_admin?

#getting form for creating new user in admin/users/new.html.erb. Instance object before saving.
def new
  @user = User.new
end

def show
  @user = User.find(params[:id])
end

def create
  @user = User.new(admin_user_params)

  if @user.save
    redirect_to admin_users_path, notice: "User successfully created, #{@user.firstname}}"
  else
    render :new # render redirects to url in the same folder AND passes on any params or values so to that page so that 
    # the user doesn't have to enter all the same information again.
  end
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])

  if @movie.update_attributes(admin_user_params)
    flash[:alert] = "User successfully edited"
  else
    render :edit
  end
end

def index
  @users = User.all.page(params[:page]).per(10)
end

def destroy
  @user = User.find(params[:id])
  UserMailer.goodbye_email(@user)
  @user.destroy
  redirect_to admin_users_path
end

protected
  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end