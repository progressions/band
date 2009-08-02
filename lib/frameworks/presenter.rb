# from Jay Fields
# http://blog.jayfields.com/2007/03/rails-presenter-pattern.html

class Presenter
  def initialize(params={})
    set_values_from_hash(params)
  end
  
  # Combines errors from individual ActiveRecord objects, so we present something nice to the user
  
  def errors
    @errors ||= ActiveRecord::Errors.new(self)
  end

  # needed by error_messages_for

  def self.human_attribute_name(attrib)
    attrib.humanize
  end

  def detect_and_combine_errors(*objects)
    objects.each do |obj|
      next if obj.nil?
      obj.valid?
      obj.errors.each { |k,m| errors.add(k,m) }
    end
  end

  # so Presenters can be used interchangeably with ActiveRecord, for things like the dom_id helper (otherwise you get a ruby warning)
  def id
    object_id
  end
  
  # creates boolean and count methods from a collection method:
  #
  # present :new_fans
  #
  # creates :new_fans?, :new_fans_count methods
  #
  def self.present(*method_names)
    method_names.each do |method_name|
      count_method = "#{method_name}_count".to_sym
      send :define_method, count_method do
        send(method_name).count
      end
    
      any_method = "#{method_name}?".to_sym
      send :define_method, any_method do
        send(method_name).any?
      end
    end
  end
    
  private
  
  def set_values_from_hash(params)
    params.each_pair do |attribute, value| 
      self.send :"#{attribute}=", value
    end unless params.nil?
  end
  
end