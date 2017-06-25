require 'test_helper'

class ActuatorCommandsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
