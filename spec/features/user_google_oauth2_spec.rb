require "rails_helper"

feature "google_oauth2 login" do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    OmniAuth.config.mock_auth[:google_oauth2] = nil
    Rails.application.env_config['omniauth.auth'] = google_oauth2_mock
    visit root_path
    click_on "ログイン"
  end

  scenario "can signin" do
    click_link "Googleでログイン"
    # expect(current_path).to eq root_path
    expect(page).not_to have_link('signin')
  end

  scenario "can not signin" do
    OmniAuth.config.add_mock(:google_oauth2, {uid: '123545', name: 'foo bar'})
    visit new_user_session_path
    click_link "Googleでログイン"
    expect(current_path).to eq new_user_registration_path
  end

  scenario "signout" do
    logout(:user) 
    expect(page).not_to have_link('signout')
    expect(page).to have_http_status(200)
  end
end