require 'test_helper'

class MisconceptionsControllerTest < ActionController::TestCase
  setup do
    @misconception = misconceptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:misconceptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create misconception" do
    assert_difference('Misconception.count') do
      post :create, misconception: { statement: @misconception.statement }
    end

    assert_redirected_to misconception_path(assigns(:misconception))
  end

  test "should show misconception" do
    get :show, id: @misconception
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @misconception
    assert_response :success
  end

  test "should update misconception" do
    put :update, id: @misconception, misconception: { statement: @misconception.statement }
    assert_redirected_to misconception_path(assigns(:misconception))
  end

  test "should destroy misconception" do
    assert_difference('Misconception.count', -1) do
      delete :destroy, id: @misconception
    end

    assert_redirected_to misconceptions_path
  end
end
