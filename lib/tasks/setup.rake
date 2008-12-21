namespace :setup do
  desc "Create initial settings"
  task :create => :environment do
    s = Setting.find_or_create_by_id(1)
    
    c = Color.find_or_create_by_id(1)
    c.save!
    
    s.color = c
    s.save
  end
end