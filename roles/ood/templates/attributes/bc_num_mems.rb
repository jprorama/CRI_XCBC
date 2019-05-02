module SmartAttributes
  class AttributeFactory
    # Build this attribute object with defined options
    # @param opts [Hash] attribute's options
    # @return [Attributes::BCNumMems] the attribute object
    def self.build_bc_num_mems(opts = {})
      Attributes::BCNumMems.new("bc_num_mems", opts)
    end
  end

  module Attributes
    class BCNumMems < Attribute
      # Hash of options used to define this attribute
      # @return [Hash] attribute options
      def opts
        @opts.reverse_merge(min: 1, step: 1)
      end

      # Value of attribute
      # Default to 4GB
      # @return [String] attribute value
      def value
        (opts[:value] || "4").to_s
      end

      # Type of form widget used for this attribute
      # @return [String] widget type
      def widget
        "number_field"
      end

      # Form label for this attribute
      # @param fmt [String, nil] formatting of form label
      # @return [String] form label
      def label(fmt: nil)
        str = opts[:label] || "Memory per CPU (GB)"
      end

      # Whether this attribute is required
      # @return [Boolean] is required
      def required
        true
      end

      # Submission hash describing how to submit this attribute
      # @param fmt [String, nil] formatting of hash
      # @return [Hash] submission hash
      def submit(fmt: nil)
        mems = value.blank? ? 1 : value.to_i
        { script: { native: ["--mem-per-cpu=", mems] } }
      end
    end
  end
end
