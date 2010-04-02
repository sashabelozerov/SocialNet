require 'test_helper'

class PhotoUserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PhotoUser.new.valid?
  end
end
