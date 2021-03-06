require_relative 'view'

module Simpler
  class Controller
    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @route = env['simpler.route']
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def parameters
      Hash[@route.path_params.zip(@request.path.split('/') - @route.path.split('/'))]
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def headers
      @response
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      @body ||= render_body
      @response.write(@body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def status(status)
      @response.status = status
    end

    def render(template)
      if template.is_a?(Hash) && template.keys.first == :plain

        headers['Content-Type'] = 'text/plain'
        @body = template.values.first
      else
        @request.env['simpler.template'] = template
      end
    end
  end
end
