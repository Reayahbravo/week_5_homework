class UsersController < ApplicationController
    #i added both of the following lines
    before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
    # before_action :authorize_user!, only: [:edit, :update, :destroy]

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
        # params.require(:user).permit(:first_name, :last_name, :current_password, :new_password, :new_password_confirmation)
        # raise @user.inspect
        current_password = params[:user][:current_password]
        new_password = params[:user][:new_password]
        new_password_confirmation = params[:user][:new_password_confirmation]
        params[:user].delete(:current_password)
        params[:user].delete(:new_password)
        params[:user].delete(:new_password_confirmation)
        user = current_user.authenticate(current_password)
        if new_password != new_password_confirmation
            flash[:alert] = 'Your passwords do not match!'
            redirect_to edit_user_path(@user)
        elsif user && new_password.present? && new_password == new_password_confirmation
            # @user = User.new(first_name: first_name, last_name: last_name, email: email, password: new_password)
            if @user.update(edit_user_params) && @user.reload.update(password: new_password)
                flash[:success] = 'Your password and details have been updated!'
                redirect_to edit_user_path(@user)
            else
                flash[:alert] = 'Something went wrong!'
                redirect_to edit_user_path(@user)
            end

        elsif user
            # @user = User.new(first_name: first_name, last_name: last_name, email: email, password: new_password)
            if @user.update(edit_user_params)
                flash[:success] = 'Your information has been updated!'
                redirect_to edit_user_path(@user)
            else
                flash[:alert] = 'Something went wrong!'
                redirect_to edit_user_path(@user)
            end
        else 
            flash[:alert] = 'Your current password does not match the existing one!'
            redirect_to edit_user_path(@user)
        end
    end

    def update_password
        #\ raise @user.inspect
        @user = User.find params[:id]
        # @user = current_user
        current_password = params[:user][:current_password]
        new_password = params[:user][:new_password]
        user = current_user&.authenticate(current_password)
        # if @user.update(user_params)
        #     #sign in the user by passing validation in case their password changed
        #     bypass_sign_in(@user)
        #     redirect_to_root_path
        if new_password == params[:user][:new_password_confirmation]
           @user.update(password: new_password)
           flash[:success] = "Password Updated"
           redirect_to edit_user_path
        else
            flash[:alert] = "Passwords Do Not Match"
            redirect_to password_edit_user_path
            # render :edit
        end
    end 

    def password_params
            params.require(:user).permit(
             :current_password,
             :new_password,
             :new_password_confirmation
            )
    end

    # def pw_update
    #     current_password = params[:user][:current_password]
    #     new_password = params[:user][:new_password]
    #     user = current_user&.authenticate(current_password)
    #     if @user && user
    #      if new_password == params[:user][:new_password_confirmation]
    #        @user.update(password: new_password)
    #        flash[:success] = "Password Updated"
    #        redirect_to edit_user_path
    #      else
    #       flash[:alert] = "Passwords Do Not Match"
    #       redirect_to pw_edit_user_path
    #      end
    #    else
    #     flash[:alert] = "Current Password is Incorrect"
    #     redirect_to pw_edit_user_path
    #    end
    #  end def pw_params
    #      params.require(:user).permit(
    #          :current_password,
    #          :new_password,
    #          :new_password_confirmation
    #          )
    #  end

    private
    def edit_user_params
        params.require(:user).permit(
            :first_name, :last_name, :email, :current_password, :new_password, :new_password_confirmation
        )
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password
      )
    end
end
