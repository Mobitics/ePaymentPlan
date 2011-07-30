class UsersController < ApplicationController
  layout "store"
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end
  
  def show
    @user = User.find params[:id]
  end
  
  
 # def edit
 #   @user = User.find params[:id]
 # end
  
  
  def edit
    @user = current_user
    @cities= {"New York"=>"1","Paris"=>"2" } 
    @states= {"Oregon"=>"1","Michigan"=>"2" }
    @countries= {"EEUU"=>"1","Roma"=>"2" }
  end

def update
  if current_user.update_attributes(params[:user])
     flash[:success] = "The account has been updated"
     redirect_to edit_user_path(current_user)
  else
     flash[:error] = current_user.errors.full_message
     render :edit
  end
end
  
  
 # def update
 #   @user = User.find params[:id]
 #   @user.update_attributes params[:user]
 #   redirect_to users_path
 # end
 # 
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end
end
