Given /^there is a web application$/ do
  true
end

Then /^(?:she should )?(.*)see an? (.*) message$/ do |visibility, message_type|
  message = has_selector?(".#{message_type}", text: /\w+/, visible: true)
  # e.g. visibility == "not"
  assert (visibility.blank? ? message : !message)
end
