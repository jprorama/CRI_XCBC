module SmartAttributes
  class AttributeFactory
    # Build this attribute object with defined options
    # @param opts [Hash] attribute's options
    # @return [Attributes::BCPartition] the attribute object
    def self.build_bc_partition(opts = {})
      Attributes::BCPartition.new("bc_partition", opts)
    end
  end

  module Attributes
    class BCPartition < Attribute
      # Type of form widget used for this attribute
      # @return [String] widget type
      def widget
        "select"
      end

      # Form label for this attribute
      # @param fmt [String, nil] formatting of form label
      # @return [String] form label
      def label(fmt: nil)
        str = opts[:label] || "Partition"
      end

      def select_choices(fmt: nil)
        parts = Array.new
{% for part in partitions %}
        parts.push(["{{ part.name }}", "{{ part.name }}"])
{% endfor %}
      end

      # Submission hash describing how to submit this attribute
      # @param fmt [String, nil] formatting of hash
      # @return [Hash] submission hash
      def submit(fmt: nil)
        { script: { partition_name: value.blank? ? nil : value.strip } }
      end
    end
  end
end
