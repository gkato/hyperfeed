require 'json'
module Hyperfeed
  class Resource

    attr_accessor :keys, :attributes

    def initialize(attributes={})
      @attributes = attributes
      @attributes.keys.each do |attr|
        self.class.__send__(:attr_accessor, attr.to_s)
        self.__send__("#{attr}=", attributes[attr])
      end

      @keys = attributes.keys
    end

    def to_json
      @attributes.to_json
    end

  end
end
