require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:zuks)
    @non_admin = users(:michael)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    second_page_of_users = User.where(activated: true).paginate(page: 2)
    second_page_of_users.second.toggle!(:activated)
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end

    # Adding extra assert code to check that other pages, besides page 1, work well
    get users_path, params: {page: 2}
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
