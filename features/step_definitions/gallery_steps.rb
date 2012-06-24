Then /^she should see a gallery$/ do
  assert has_selector?("#gallery")
  assert has_selector?("#thumbnails")
end
