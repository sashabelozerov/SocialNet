class SessionsController < ApplicationController
  def create
	@password = params[:password]
	@login = params[:login]
	@users = User.all
		@users.each do |user|
			if user.login.downcase == @login.downcase && user.password.downcase == @password.downcase
				session[:id] = user.id
				flash[:notice] = "Welcome, #{User.find(session[:id]).name}!"
				redirect_to user_url(user) and return
			end
		end
	flash[:error] = "Wrong login and/or password"
	redirect_to login_url
  end

  def destroy
	reset_session
	redirect_to users_url
  end

end
