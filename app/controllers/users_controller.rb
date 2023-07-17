class UsersController < ApplicationController
    skip_before_action :authenticate, only: [:signup, :login]
    
    def signup
        user = User.new(name: params[:name], email: params[:email], password: params[:password])

        if user.save 
            render json: {success: true, user: user, status: 200}
        else
            render json: {errors: user.errors.full_messages, status: 400}
        end
    end

    def login 
        user = User.find_by(email: params[:email])
    
        if user && user.authenticate(params[:password])
          token = user.generate_token!(@ip)
          render json: { success: true, user: user, token: token, status: 200 }
        else
          render json: { errors: "Invalid email or password", status: 401 }
        end
    end

    def me
        user = @current_user
    
        if user
          render json: { success: true, user: user, status: 200 }
        else
          render json: { errors: "Unauthorized", status: 401 }
        end
    end

    def logout
        if @current_user && @token.update(revocation_date: DateTime.now)
            render json: { success: true, message: "Logged out successfully", status: 200 }
        else
            render json: { errors: "Logout failed", status: 400 }
        end
    end
    
end
