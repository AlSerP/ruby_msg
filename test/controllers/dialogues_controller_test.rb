require 'test_helper'

class DialoguesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dialogues_index_url
    assert_response :success
  end

end
