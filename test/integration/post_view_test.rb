require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ViewTest do

  before do
    post = FactoryGirl.create(:post, :title => 'the real power', :description => 'very very long and useful post', :admin_id => FactoryGirl.create(:admin_user).id, :upload_files => [FactoryGirl.create(:upload_file)])
    3.times do
      FactoryGirl.create(:post, :upload_files => [FactoryGirl.create(:upload_file)], :admin_id => FactoryGirl.create(:admin_user).id)
    end
    post.categories.create(:name => 'special')
    4.times do
      FactoryGirl.create(:category)
    end
    post.tag_list = 'tag1, tag2, tag3'
    post.save
  end

  it 'must find the description of the post' do
    visit posts_path
    within('.form-search') do
      fill_in 'search', :with => 'power'
    end
    find('.form-search input').native.send_keys :return
    assert page.has_no_content?('Text for post -> my post')
  end

  it 'must show category related posts' do
    visit posts_path
    within '.categories ul' do
      click_link 'special'
    end
    assert page.has_no_content?('Text for post -> my post')
  end

  it 'must show tag related posts' do
    visit posts_path
    click_link 'tag2', :match => :prefer_exact
    assert page.has_content?('the real power')
  end

  it 'must show tag related posts from tag field' do
    visit posts_path
    within('.block.tags') do
      click_link 'tag2'
    end
    assert page.has_content?('the real power')
  end

  it 'must render post show' do
    visit posts_path
    click_link 'the real power'
    assert page.has_content?('New Comment')
  end

end