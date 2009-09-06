Given %r{^a global setting exists$} do
  unless Setting.find_by_id(1)
    Given "a setting: \"global\" exists with id: 1"
  end
end

Given %r{^a global setting exists with #{capture_fields}$} do |fields|
  unless Setting.find_by_id(1)
    Given "a setting: \"global\" exists with id: 1"
  end
  s = Setting.find_by_id(1)
  params = parse_fields(fields)
  s.update_attributes(params)
end