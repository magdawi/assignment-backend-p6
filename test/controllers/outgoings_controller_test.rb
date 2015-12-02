require 'test_helper'

class OutgoingsControllerTest < ActionController::TestCase
  setup do
    @outgoing = outgoings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outgoings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outgoing" do
    assert_difference('Outgoing.count') do
      post :create, outgoing: { category_id: @outgoing.category_id, date: @outgoing.date, note: @outgoing.note, pocket_id: @outgoing.pocket_id, sum: @outgoing.sum, user_id: @outgoing.user_id }
    end

    assert_redirected_to outgoing_path(assigns(:outgoing))
  end

  test "should show outgoing" do
    get :show, id: @outgoing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outgoing
    assert_response :success
  end

  test "should update outgoing" do
    patch :update, id: @outgoing, outgoing: { category_id: @outgoing.category_id, date: @outgoing.date, note: @outgoing.note, pocket_id: @outgoing.pocket_id, sum: @outgoing.sum, user_id: @outgoing.user_id }
    assert_redirected_to outgoing_path(assigns(:outgoing))
  end

  test "should destroy outgoing" do
    assert_difference('Outgoing.count', -1) do
      delete :destroy, id: @outgoing
    end

    assert_redirected_to outgoings_path
  end
end
