class AuthController < ApplicationController
  def create
    params[:domain] ||= "g5searchmarketing.com"
    authenticate_with_open_id((params[:domain]),
                    {:required => ["http://axschema.org/contact/email",
                                "http://axschema.org/namePerson/first",
                                "http://axschema.org/namePerson/last"],
                                :return_to  => login_url
    }) do |result, identity_url, registration|
      if result.successful?
        openid_response = parse_openid_response(request.env[Rack::OpenID::RESPONSE])
        if openid_response["http://axschema.org/contact/email"].first.match(/g5searchmarketing.com/)
        
          identity = request.env[Rack::OpenID::RESPONSE].identity_url
          user = User.find_by_identity(identity) || User.create_with_openid(identity, openid_response)
          session[:user_id] = user.id
          redirect_to root_url
        else
          redirect_to login_url
        end
      else
        redirect_to login_url
      end
    end

  end

  def destroy
    reset_session
    redirect_to root_url
  end

  private
  def parse_openid_response(openid_reponse)
    ax_response = OpenID::AX::FetchResponse.from_success_response(openid_reponse)
    ax_response.data
  end
end
