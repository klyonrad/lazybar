module ApplicationHelper # rubocop:disable Style/Documentation
  # detect either admin oder user sign in
  def signed_in?
    user_signed_in? || admin_signed_in?
  end
end
