class JwtMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    auth_header = request.get_header("HTTP_AUTHORIZATION")

    if auth_header.present?
      token = auth_header.split(" ").last
      decoded = JsonWebToken.decode(token)

      if decoded
        env["current_user_id"] = decoded["user_id"]
      else
        return unauthorized_response
      end
    end

    @app.call(env)
  end

  private

  def unauthorized_response
    [ 401, { "Content-Type" => "application/json" }, [ { error: "Unauthorized" }.to_json ] ]
  end
end
