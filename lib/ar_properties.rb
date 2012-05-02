require 'active_record'
require 'ar_properties/property'
require 'ar_properties/version'

module ActiveRecord
  module Properties
    extend ActiveSupport::Concern

    def self.activate!
      ActiveRecord::Base.send(:include, self)
    end

    class PropertyError < StandardError
    end

    module ClassMethods
      def columns
        @columns ||= properties.map(&:to_column)
      end

      def properties
        @properties ||= []
      end

      def property(*args)
        Property.new(connection, *args).tap {|x| properties << x }
      end

      def timestamps(suffix=:at)
        raise PropertyError, "unknown timestamps suffix: #{suffix.inspect}" unless %w[at on].include?(suffix.to_s)
        property :"created_#{suffix}", :time
        property :"updated_#{suffix}", :time
      end
    end
  end
end
