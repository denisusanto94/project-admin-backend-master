class ApplicationController < ActionController::API

    def not_found
      render json: { error: 'not_found' }
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
              render json: {  status: :success,
                      data:{
                              id: @current_user.id,
                              username: @current_user.username,
                              email: @current_user.email,
                              created_at: @current_user.created_at,
                              updated_at: @current_user.updated_at,
                          }
                    }
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
    