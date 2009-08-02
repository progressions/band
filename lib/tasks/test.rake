task :thingy => :environment do
  File.open("./log/funk.log", "a") do |f|
    f.write("It is now #{Time.now}\n")
  end
end