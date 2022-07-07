require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:zuks)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger', "The form contains 4 errors."
    # The below assert_select is not necessary.
    # It is just to demonstrate another way (possibly better) of testing for the right number of errors
    assert_select 'div#error_explanation ul li', count: 4
  end
end
