require 'test_helper'

class SourceRulesControllerTest < ActionController::TestCase
  setup do
    @source_rule = source_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_rule" do
    assert_difference('SourceRule.count') do
      post :create, source_rule: { action: @source_rule.action, name: @source_rule.name, source: @source_rule.source, value: @source_rule.value }
    end

    assert_redirected_to source_rule_path(assigns(:source_rule))
  end

  test "should show source_rule" do
    get :show, id: @source_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_rule
    assert_response :success
  end

  test "should update source_rule" do
    patch :update, id: @source_rule, source_rule: { action: @source_rule.action, name: @source_rule.name, source: @source_rule.source, value: @source_rule.value }
    assert_redirected_to source_rule_path(assigns(:source_rule))
  end

  test "should destroy source_rule" do
    assert_difference('SourceRule.count', -1) do
      delete :destroy, id: @source_rule
    end

    assert_redirected_to source_rules_path
  end
end
