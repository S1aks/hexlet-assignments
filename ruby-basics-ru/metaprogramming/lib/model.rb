# frozen_string_literal: true

# BEGIN
require 'date'

module Model
  def self.included(base)
    base.attr_reader :attributes
    base.extend(ClassMethods)
  end

  def initialize(params = {})
    @attributes = {}
    self.class.options.each do |name, options|
      if params.key?(name)
        set_var(name, params[name])
      else
        set_var(name, options[:default])
      end
    end
  end

  def set_var(name, value)
    options = self.class.options[name]
    new_value = convert_value(value, options[:type])
    instance_variable_set("@#{name}", new_value)
    @attributes[name] = new_value
  end

  module ClassMethods
    def options
      @options.nil? ? {} : @options
    end

    def attribute(name, options = {})
      return unless options.key?(:type)

      @options ||= {}
      @options[name] = options

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        set_var(name, value)
      end
    end
  end

  private

  def convert_value(value, type)
    return nil if value.nil?

    case type
    when :string
      value.to_s
    when :integer
      value.to_i
    when :float
      value.to_f
    when :boolean
      !!value
    when :symbol
      value.to_sym
    when :array
      Array(value)
    when :hash
      Hash(value)
    when :datetime
      DateTime.parse(value)
    else
      value
    end
  end
end
# END
