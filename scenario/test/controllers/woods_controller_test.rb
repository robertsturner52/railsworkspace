require 'test_helper'

class WoodsControllerTest < ActionController::TestCase
  test "should get stream" do
    get :stream
    assert_response :success
  end

  test "should get mountain" do
    get :mountain
    assert_response :success
  end

  test "should get swim" do
    get :swim
    assert_response :success
  end

  test "should get fish" do
    get :fish
    assert_response :success
  end

  test "should get hike" do
    get :hike
    assert_response :success
  end

  test "should get climb" do
    get :climb
    assert_response :success
  end

  test "should get forest" do
    get :forest
    assert_response :success
  end

end
