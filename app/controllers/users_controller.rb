class UsersController < ApplicationController
    #i added both of the following lines
    #before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
    #before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
      @user = User.new
    end
  
    def create
    #   render json: params
      @user = User.new user_params

      if @user.save
          # The `session` is an object useable in controllers
      # that uses cookies to store encrypted data. To sign
      # in a user, we store their `user_id` in the session for
      # later retrieval.
      session[:user_id] = @user.id
      redirect_to home_path
      
      else
        render :new
      end
    end
  
    def edit
        @user = User.find params[:id]
        # #i did
        # @user = current_user
        # if @user.update(user_params)
        #     #sign in the user by passing validation in case their password changed
        #     bypass_sign_in(@user)
        #     redirect_to_root_path
        # else
        #     render :edit
        # end  
    end

    def update
        @user = User.find params[:id]
        # raise @user.inspect
        if @user.update edit_user_params
            flash[:notice] = 'Your information has been updated!'
            # redirect_to @user
            # user = User.find params[:id]
            # user.update(user_params)
         
          else
            flash[:alert] = 'Your information did not update.'
            # render :edit
          end
          redirect_to edit_user_path(@user)
        end

    #also def update_password block all me
    def update_password
        @user = current_user
        if @user.update(user_params)
            #sign in the user by passing validation in case their password changed
            bypass_sign_in(@user)
            redirect_to_root_path
        else
            render :edit
        end
    end

    private
    def edit_user_params
        params.require(:user).permit(
            :first_name, :last_name, :email 
        )
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password, :password_confirmation
      )
    end
end