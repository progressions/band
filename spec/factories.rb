require 'factory_girl'

# collection of factory helper methods
module FactoryHelper
  # used to create a factory and use block to do any stubbing required
  def create_factory(symbol, params = {})
    factory = Factory.build(symbol, params)
    yield(factory)
    factory.save!

    factory
  end
end

Factory.sequence :name do |num|
  "name#{num}"
end

Factory.sequence :email do |num|
  "name#{num}@example.com"
end

Factory.define :style do |f|
  f.title             "Default"
end

Factory.define :setting do |f|
  f.site_name         "World Racketeering Squad"
  f.artist_name       "World Racketeering Squad"
  f.association       :style
end
