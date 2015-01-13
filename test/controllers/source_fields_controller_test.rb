require 'test_helper'

class SourceFieldsControllerTest < ActionController::TestCase
  setup do
    @source_field = source_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_field" do
    assert_difference('SourceField.count') do
      post :create, source_field: { field_type: @source_field.field_type, key_name: @source_field.key_name, source_id: @source_field.source_id }
    end

    assert_redirected_to source_field_path(assigns(:source_field))
  end

  test "should show source_field" do
    get :show, id: @source_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_field
    assert_response :success
  end

  test "should update source_field" do
    patch :update, id: @source_field, source_field: { field_type: @source_field.field_type, key_name: @source_field.key_name, source_id: @source_field.source_id }
    assert_redirected_to source_field_path(assigns(:source_field))
  end

  test "should destroy source_field" do
    assert_difference('SourceField.count', -1) do
      delete :destroy, id: @source_field
    end

    assert_redirected_to source_fields_path
  end
end
