require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get user_index" do
    get admins_user_index_url
    assert_response :success
  end

  test "should get set_user" do
    get admins_set_user_url
    assert_response :success
  end

  test "should get user_comments" do
    get admins_user_comments_url
    assert_response :success
  end

  test "should get user_posts" do
    get admins_user_posts_url
    assert_response :success
  end

end
