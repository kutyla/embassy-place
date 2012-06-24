When /^she visits the (\S*)(?: page)?$/ do |page_name|
  visit(path_for(page_name))
end

Then /^she should see the (\S*)(?: page)?$/ do |page_name|
  assert_equal current_path, path_for(page_name)
end

Then /^(?:she should )?not see a 404 page$/ do
  assert has_no_content?("404")
end

Then /^she should be able to browse the site$/ do
  original_page = current_path

  browsable_pages = ["homepage", "gallery", "features", "contact", "posts"]
  browsable_pages.each do |page_name|
    click_link("nav-#{page_name}")
    step(%Q{she should see the #{page_name} page})
    visit(original_page)
  end
end

Then /^she should be able to download the brochure$/ do
  click_link("brochure-pdf")
  assert_response :success
end
