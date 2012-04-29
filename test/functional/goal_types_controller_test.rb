require 'test_helper'

class GoalTypesControllerTest < ActionController::TestCase
  setup do
    @goal_type = goal_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goal_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal_type" do
    assert_difference('GoalType.count') do
      post :create, goal_type: { name: @goal_type.name }
    end

    assert_redirected_to goal_type_path(assigns(:goal_type))
  end

  test "should show goal_type" do
    get :show, id: @goal_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goal_type
    assert_response :success
  end

  test "should update goal_type" do
    put :update, id: @goal_type, goal_type: { name: @goal_type.name }
    assert_redirected_to goal_type_path(assigns(:goal_type))
  end

  test "should destroy goal_type" do
    assert_difference('GoalType.count', -1) do
      delete :destroy, id: @goal_type
    end

    assert_redirected_to goal_types_path
  end
end
