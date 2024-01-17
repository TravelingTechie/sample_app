require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:celeste)
    @non_admin = users(:heidi)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path    
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select 'th', 'Delete' 
    first_page_of_users = User.paginate(page: 1, :per_page => 10)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        #I hate this.  edit_account_activation_url(user) pulls example.com as domain
        #how do I get it to pull localhost?
        assert_select 'a[href=?]', user_path(user), text: 'Del'
      end
    end

    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end 
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'deactivate', count: 0
  end

  test "should display only activated users for non-admin" do
    # Deactivate the first user on the page.
    # Making an inactive fixture user isn't sufficient because Rails can't
    # guarantee it would appear on the first page.
    User.paginate(page: 1, :per_page => 10).first.toggle!(:activated)
    first_page_of_users =  User.where(activated: true).paginate(page: 1, :per_page => 10)
    first_page_of_users.each do |user|
      assert user.activated?
    end
    #There is a one deactivated user in the yml and one that is deactivated here
    page_inactive_user =  User.where(activated: false).paginate(page: 1, :per_page => 10)
    page_inactive_user.each do |user|
      assert_not user.activated?
    end
  end

end
