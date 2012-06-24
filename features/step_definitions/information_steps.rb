And /^asks a question$/ do
  within("#new_note") do
    fill_in('note_name', with: "a name")
    fill_in('note_email', with: Faker::Internet.email)
    fill_in('note_message', with: "Some question.")
    click_button("Send")
  end
end

And /^asks a question without a message$/ do
  within("#new_note") do
    click_button("Send")
  end
end
