module Api
    module V1
        class UsersController < Api::ApiController
            respond_to :json

            def create 
                user = User.new(user_params)
                if user.save
                    json_response(user,201,"Success",UserSerializer,"user")
                else
                    error(user.errors,422)
                end
            end

            def show
                user=User.find_by(id: request.headers["X-User-id"].to_i)
                if user
                    json_response(user,200,"Success",UserSafeParamsSerializer,"user")
                else
                    error("Not found",404)
                end                 
            end

            def update
                user = User.find_by(id: request.headers["X-User-id"].to_i)
                if user && user.update(update_user_params)
                    json_response(user,200,"Success",UserSafeParamsSerializer,"user")
                elsif user.nil?
                    error("NotFound",404)
                else
                    error(user.errors,422)
                end
            end

            def destroy
                user = User.find_by(id: request.headers["X-User-id"].to_i)
                if user
                    user.destroy
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
