require 'test_helper'

class GoalProgressesControllerTest < ActionController::TestCase
  setup do
    @goal_progress = goal_progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goal_progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal_progress" do
    assert_difference('GoalProgress.count') do
      post :create, goal_progress: { completed: @goal_progress.completed, course_class_id: @goal_progress.course_class_id, goal_id: @goal_progress.goal_id, notes: @goal_progress.notes }
    end

    assert_redirected_to goal_progress_path(assigns(:goal_progress))
  end

  test "should show goal_progress" do
    get :show, id: @goal_progress
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goal_progress
    assert_response :success
  end

  test "should update goal_progress" do
    put :update, id: @goal_progress, goal_progress: { completed: @goal_progress.completed, course_class_id: @goal_progress.course_class_id, goal_id: @goal_progress.goal_id, notes: @goal_progress.notes }
    assert_redirected_to goal_progress_path(assigns(:goal_progress))
  end

  test "should destroy goal_progress" do
    assert_difference('GoalProgress.count', -1) do
      delete :destroy, id: @goal_progress
    end

    assert_redirected_to goal_progresses_path
  end
end
