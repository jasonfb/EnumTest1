require 'rails_helper'

describe 'interaction for UsersController', type: :feature do
  include HotGlue::ControllerHelper
  include ActionView::RecordIdentifier

  #HOTGLUE-SAVESTART
  #HOTGLUE-END
  

  let!(:user1) {create(:user ,  )}
   

  describe "index" do
    it "should show me the list" do
      visit users_path
      expect(page).to have_content(user1.status)
    end
  end

  describe "new & create" do
    it "should create a new User" do
      visit users_path
      click_link "New User"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New User")]')
      list_of_status = User.defined_enums['status'].keys 
      new_status = list_of_status[rand(list_of_status.length)].to_s 
      find("select[name='user[status]']  option[value='#{new_status}']").select_option
      click_button "Save"
      expect(page).to have_content("Successfully created")
      expect(page).to have_content(new_status)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit users_path
      find("a.edit-user-button[href='/users/#{user1.id}/edit']").click

      expect(page).to have_content("Editing #{user1.name.squish || "(no name)"}")
      list_of_status = User.defined_enums['status'].keys 
      new_status = list_of_status[rand(list_of_status.length)].to_s 
      find("select[name='user[status]']  option[value='#{new_status}']").select_option
      click_button "Save"
      within("turbo-frame#__#{dom_id(user1)} ") do
        expect(page).to have_content(new_status)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit users_path
      accept_alert do
        find("form[action='/users/#{user1.id}'] > input.delete-user-button").click
      end
      expect(page).to_not have_content(user1.name)
      expect(User.where(id: user1.id).count).to eq(0)
    end
  end
end

