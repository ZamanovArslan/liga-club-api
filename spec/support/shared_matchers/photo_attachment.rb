RSpec::Matchers.define :be_a_image_attachment do |_expected|
  match do |actual|
    %w[large medium thumb].each { |version| expect(actual[version]["url"]).to a_string_including("/uploads/") }
  end
  failure_message do |actual|
    "expected that #{actual} contains image attachment"
  end
end

RSpec::Matchers.define :be_a_empty_image_attachment do |_expected|
  match do |actual|
    %w[large medium thumb].each { |version| expect(actual[version]["url"]).to be_nil }
  end
  failure_message do |actual|
    "expected that #{actual} contains image attachment"
  end
end
