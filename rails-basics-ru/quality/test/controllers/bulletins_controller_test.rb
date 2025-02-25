# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get bulletins_path(bulletins)

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'get show' do
    bulletin = bulletins('bulletin_1')

    get bulletin_path(bulletin)

    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h4', bulletin.title
    assert_select 'p', bulletin.body
  end
end
