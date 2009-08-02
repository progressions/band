When /^I fill in the captcha so it is (true|false)$/ do |value|
  if value == "true"
    Ambethia::ReCaptcha::SKIP_VERIFY_ENV << "cucumber"
  else
    Ambethia::ReCaptcha::SKIP_VERIFY_ENV.delete("cucumber")
  end
end