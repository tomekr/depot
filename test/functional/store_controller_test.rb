require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    # Looks for an element named a that is contained in an element with an id
    # with a value of side, which is contained within an element with an id
    # with a value of columns. This test verifies that there are a minimum of
    # four such elements. 
    assert_select '#columns #side a', minimum: 4
    # Verifies that there are three elements with a class name of entry inside
    # the main portion of the page.
    assert_select '#main .entry', minimum: 3
    # Verifies that there is an h3 element with the title of the Ruby book that
    # we had entered previously
    assert_select 'h3', 'Programming Ruby 1.9'
    # Verifies that the price is formatted correctly.
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
