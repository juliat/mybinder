require 'test_helper'

class ModsControllerTest < ActionController::TestCase
  setup do
    @mod = mods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mod" do
    assert_difference('Mod.count') do
      post :create, mod: { days: @mod.days, unit_id: @mod.unit_id }
    end

    assert_redirected_to mod_path(assigns(:mod))
  end

  test "should show mod" do
    get :show, id: @mod
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mod
    assert_response :success
  end

  test "should update mod" do
    put :update, id: @mod, mod: { days: @mod.days, unit_id: @mod.unit_id }
    assert_redirected_to mod_path(assigns(:mod))
  end

  test "should destroy mod" do
    assert_difference('Mod.count', -1) do
      delete :destroy, id: @mod
    end

    assert_redirected_to mods_path
  end
end
