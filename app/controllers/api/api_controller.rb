module Api
    class ApiController < ApplicationController



        protected

        def update_remember_token(user)
            user.generate_auth_token
        end

        def update_time_stamp(user)
            user.generate_time_stamp
        end

        def find_user(user_id,remember_token)
            if user_id.nil? || remember_token.nil?
                error("Bad Request",400) and return
            end
            user = User.find_by(id: user_id.to_i)
            if user
                if BCrypt::Password.new(user.remember_digest).is_password?(remember_token)
                   if user.auth_token_expired?
                        error("Session Token Expired!",401) and return
                    else    
                        return user
                    end
                else
                    error("Invalid Session Token",401) and return
                end
            else
                error("You are not logged in",401) and return
            end
        end

        def error(message,status)
            render json: {errors: message}, status: status
        end

        def json_response(data,status,result,serializer,root)
            render json: data,serializer: serializer, root: root.to_sym, status: status, result: result
        end

        def default_serializer_options
            {root: true}
        end
    end
end
