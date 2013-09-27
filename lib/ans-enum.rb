require "ans-enum/version"

module Ans
  module Enum
    def self.included(m)
      instance_methods = Module.new
      class_methods = Module.new

      m.send :include, instance_methods
      m.send :extend, class_methods

      class_methods.class_eval do
        define_method :enum_of do |name,enums|
          status_class = Class.new
          status_class.class_eval do
            define_method :initialize do |type=nil|
              @type = type.try(:to_sym)
            end

            enums.each do |enum|
              define_method :"#{enum}?" do
                @type && @type == enum.try(:to_sym)
              end
            end

            define_method :to_s do
              (@type || :null).to_s
            end
          end

          instance_methods.class_eval do
            enums.each do |enum|
              define_method :"#{name}_#{enum}" do
                status_class.new enum
              end
            end

            define_method :"#{name}_null" do
              status_class.new
            end
          end
        end
      end
    end
  end
end
