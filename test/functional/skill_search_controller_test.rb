require 'test_helper'

class SkillSearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get skill_result" do
    get :skill_result
    assert_response :success
  end

end
