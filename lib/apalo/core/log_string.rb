module Apalo
  module Core
    module LogString
      def image?
        self =~ /\.(png|PNG|jpg|JPG|gif|GIF|svg|SVG|jpeg|JPEG) HTTP\/1\.\d$/
      end

      def test_regex(regex)
        return true if self =~ regex
        false
      end

      def is_a_bot?
        test_regex %r{^.*(Yahoo! Slurp|Googlebot|TurnitinBot|Twiceler|msnbot|Gigabot|Yandex|TurnitinBot|ia_archiver).*$}
      end

      def is_get?
        test_regex %r{^GET .*$}
      end

      def is_post?
        test_regex %r{^POST .*$}
      end
      
      def is_options?
        test_regex %r{^OPTIONS .*$}
      end
      
      def is_head?
        test_regex %r{^HEAD .*$}
      end
      
      def is_propfind?
        test_regex %r{^PROPFIND .*$}
      end
      
      def is_put?
        test_regex %r{^PUT .*$}
      end
      
      def is_lock?
        test_regex %r{^LOCK .*$}
      end

    end

    
  end # module Core
end # end module Apalo

class String
  include Apalo::Core::LogString
end
