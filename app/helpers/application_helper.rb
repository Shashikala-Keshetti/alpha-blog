module ApplicationHelper

  def avatar_for(user, options = { size: '200x200' })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    robot_url = "https://robohash.org/#{hash}.png/bgset_any?size=#{size}"
    image_tag(robot_url, alt: user.username, class: "rounded-circle shadow mx-auto d-block", size: "#{size}x#{size}") 
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    !!current_user
  end

end
