require 'rails_helper'

RSpec.feature 'UserSignUp', type: :feature do
  scenario "User successfully signs up with valid information" do
    visit unauthenticated_root_path 
    
    fill_in "Name", with: "TestName"
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    
    click_button "Sign up"
    
    expect(page).to have_content("Categories")
  end
end
