def sign_in
  @user ||= create(:user)
  page.driver.post user_session_path, :user => {:email => @user.email, :password => @user.password}
end
