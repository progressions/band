namespace :setup do
  desc "Create initial settings"
  task :create => :environment do
    s = Setting.find_or_create_by_id(1, :style => Style.find_or_create_by_id(1))
  end
end