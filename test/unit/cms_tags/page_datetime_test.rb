require File.dirname(__FILE__) + '/../../test_helper'

class PageDateTimeTest < ActiveSupport::TestCase
  
  def test_initialize_tag
    %w(
      <cms:page:content:datetime/>
      <cms:page:content:datetime>
    ).each do |tag_signature|
      assert tag = CmsTag::PageDateTime.initialize_tag(cms_pages(:default), tag_signature)
      assert_equal 'content', tag.label
    end
  end
  
  def test_initialize_tag_failure
    %w(
      <cms:page:content:not_datetime/>
      <cms:page:content/>
      <cms:not_page:content/>
      not_a_tag
    ).each do |tag_signature|
      assert_nil CmsTag::PageDateTime.initialize_tag(cms_pages(:default), tag_signature)
    end
  end
  
  def test_content_and_render
    tag = CmsTag::PageDateTime.initialize_tag(cms_pages(:default), "<cms:page:content:datetime>")
    assert tag.content.blank?
    time = 2.days.ago
    tag.content = time
    assert_equal time, tag.content
    assert_equal time, tag.read_attribute(:content_datetime)
    assert_equal time.to_s, tag.render
  end
  
end