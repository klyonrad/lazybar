# frozen_string_literal: true

module ApplicationHelper
  # detect either admin oder user sign in
  def signed_in?
    user_signed_in? || admin_signed_in?
  end
end
