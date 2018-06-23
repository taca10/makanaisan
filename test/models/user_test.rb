require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "hogehoge", email: "alaor@example.com", password: "foobar", password_confirmation: "foobar") 
  end

  test "should be valid" do
    @user.delete
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should not be too length " do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too length" do
    @user.email = "a" * 254 + "example.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user_email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved lower-case" do
    mixed_case_email = "Foo@ExAMple.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be not blank" do
    @user.password = @user.password_confirmation = " " 
    assert_not @user.valid?
  end

   test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
