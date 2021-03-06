require 'shoulda/matchers/util/word_wrap'

module Shoulda
  module Matchers
    # @private
    module Util
      def self.deconstantize(path)
        if defined?(ActiveSupport::Inflector) &&
          ActiveSupport::Inflector.respond_to?(:deconstantize)
          ActiveSupport::Inflector.deconstantize(path)
        else
          path.to_s[0...(path.to_s.rindex('::') || 0)]
        end
      end

      def self.safe_constantize(camel_cased_word)
        if defined?(ActiveSupport::Inflector) &&
          ActiveSupport::Inflector.respond_to?(:safe_constantize)
          ActiveSupport::Inflector.safe_constantize(camel_cased_word)
        else
          begin
            camel_cased_word.constantize
          rescue NameError
            nil
          end
        end
      end

      def self.indent(string, width)
        indentation = ' ' * width
        string.split(/[\n\r]/).map { |line| indentation + line }.join("\n")
      end

      def self.a_or_an(next_word)
        if next_word =~ /\A[aeiou]/i
          "an #{next_word}"
        else
          "a #{next_word}"
        end
      end
    end
  end
end
