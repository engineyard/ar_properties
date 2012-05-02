module ActiveRecord
  module Properties
    class Property
      def initialize(base, name, type, options={})
        @name, @type, @base = name, type, base

        native = base.native_database_types
        @limit = options.fetch(:limit) do
          native[type][:limit] if native[type].is_a?(Hash)
        end

        @precision = options[:precision]
        @scale     = options[:scale]
        @default   = options[:default]
        @null      = options[:null]

        unless base.native_database_types.keys.include?(type.try(:to_sym))
          raise PropertyError, "unknown type: #{type.inspect}"
        end
      end

      attr_reader :base, :name, :type, :precision, :scale, :default, :null, :limit

      def to_column
        ConnectionAdapters::Column.new(name.to_s, default.try(:to_s), sql_type, null).tap do |column|
          column.primary = primary?
        end
      end

      def sql_type
        base.type_to_sql(type.to_sym, limit, precision, scale)
      end

      def primary?
        type.to_sym == :primary_key
      end
    end
  end
end
