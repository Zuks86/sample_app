require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "email@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
    ["Name can't be blank", 
      "Email is invalid",
      "Password is too short (minimum is 6 characters)", 
      "Password confirmation doesn't match Password"].each do |error|
      assert_select "li", error
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Valid User",
          email: "valid@user.com",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end
end
