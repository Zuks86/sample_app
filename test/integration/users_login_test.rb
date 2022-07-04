require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "flash message does not persist" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      session: {
        email: "email@valid",
        password: "foo"
      }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
