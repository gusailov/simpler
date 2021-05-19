module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :path_params, :path

      def initialize(method, path, controller, action)
        @method = method
        @path = path.gsub(%r{/:(\S*)}, '')
        @path_params = params(path)
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(@path) && @path_params.length == params(path).length
      end

      def params(path)
        (path.split('/') - @path.split('/')).map { |e| e.delete(':').to_sym }
      end
    end
  end
end
