require 'test_helper'

class PhotoUsersControllerTest < ActionController::TestCase
  def test_create_invalid
    PhotoUser.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PhotoUser.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    photo_user = PhotoUser.first
    delete :destroy, :id => photo_user
    assert_redirected_to root_url
    assert !PhotoUser.exists?(photo_user.id)
  end
end
