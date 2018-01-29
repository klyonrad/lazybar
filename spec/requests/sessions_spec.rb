require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user) { create :user }
  let(:admin) { create :admin }

  describe 'Session Controller' do
    it 'signs user in and out' do
      sign_in user
      get root_path
      expect(controller.current_user).to eq(user)

      sign_out user
      get root_path
      expect(controller.current_user).to be_nil
    end

    it 'signs admin in and out' do
      sign_in admin
      get root_path
      expect(controller.current_admin).to eq(admin)

      sign_out admin
      get root_path
      expect(controller.current_admin).to be_nil
    end
  end

  describe 'Admin Panel' do
    it 'is not public' do
      get rails_admin_path
      expect(response).to redirect_to new_admin_session_path
    end

    it 'is not allowed for users' do
      sign_in user
      get rails_admin_path
      expect(response).to redirect_to new_admin_session_path
    end

    it 'is allowed for admins' do
      sign_in admin
      get rails_admin_path
      expect(response).to be_success
    end
  end
end
