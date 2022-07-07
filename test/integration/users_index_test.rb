require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end

    # Adding extra assert code to check that other pages, besides page 1, work well
    get users_path, params: {page: 2}
    User.paginate(page: 2).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
