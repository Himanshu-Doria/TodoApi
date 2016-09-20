module Api
    module V1
        class UsersController < Api::ApiController
            respond_to :json

            before_action :logged_in?, only: [:show,:update,:destroy]
            before_action :authorized?, only: [:update,:destroy]

            def create 
                user = User.new(user_params)
                if user.save
                    json_response(user,201,"Success",UserSerializer,"user")
                else
                    error(user.errors,422)
                end
            end

            def show
                if @user.nil?
                    return
                end
                if @user
                    json_response(@user,200,"Success",UserSafeParamsSerializer,"user")
                else
                    error("Not found",404)
                end                 
            end

            def update
                if @user.nil?
                    return
                end
                if @user && @user.update(update_user_params)
                    json_response(@user,200,"Success",UserSafeParamsSerializer,"user")
                elsif user.nil?
                    error("NotFound",404)
                else
                    error(@user.errors,422)
                end
            end

            def destroy
                if @user.nil?
                    return
                end
                if @user
                    @user.destroy
                    head 204
                else
                    error("Not Found",404)
                end
            end

            private

            def user_params
                params.require(:user).permit(:email,:password,:password_confirmation)
            end

            def update_user_params
                params.require(:user).permit(:email,:password,:password_confirmation,:name,:age,:phone,:address)
            end
        end
    end
end
