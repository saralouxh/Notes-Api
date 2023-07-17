class ApplicationController < ActionController::API
    before_action :authenticate

    include ActionController::HttpAuthentication::Token::ControllerMethods

    def authenticate 
        authenticate_token || render_unauthorized
    end

    def authenticate_token
        @ip = request.remote_ip || 'unknown'

        authenticate_with_http_token do |token, _option|
            @token = Token.find_by(value: token)

            if @token.nil?
                render_unauthorized
            else
                if @token.expiry.after?(DateTime.now) && @token.revocation_date.blank?
                    @current_user = @token.user 
                    @current_user
                else
                    render_unauthorized
                end
            end
        end
    end

    def render_unauthorized
        logger.debug "UNAUTHORIZED REQUEST"
        render json: {error: "Bad credentials", status: 401}
    end
end
