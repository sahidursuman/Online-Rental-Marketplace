require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { first_name:  "",
    																last_name: "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successful edit" do
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    firstname  = "Foo"
    lastname = "Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { first_name:  firstname,
    																last_name: lastname,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstname,  @user.first_name
    assert_equal lastname, @user.last_name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    firstname  = "Foo"
    lastname = "Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { first_name:  firstname,
    																last_name: lastname,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
