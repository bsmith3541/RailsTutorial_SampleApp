require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div#error_explanation li', text: "Name can't be blank"
    assert_select 'div#error_explanation li', text: "Email is invalid"
    assert_select 'div#error_explanation li', text: "Password is too short (minimum is 6 characters)"
    
    assert_select 'div.field_with_errors label[for=user_name]'
    assert_select 'div.field_with_errors label[for=user_email]'
    assert_select 'div.field_with_errors label[for=user_password]'
    assert_select 'div.field_with_errors label[for=user_password_confirmation]'

  end

  test "valid signup information" do
    get signup_path
    name     = "Example User"
    email    = "user@example.com"
    password = "password"
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  name,
                                            email: email,
                                            password:              password,
                                            password_confirmation: password }
    end
    assert_template 'users/show'
  end
end
