require_relative 'view'

module Simpler
  class Controller
    attr_reader :name, :request, :response, :parameters

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @parameters = {}
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      send(action)
      write_response

      @response.finish
    end

    def path_parameters(route)
      @parameters = Hash[route.path_params.zip(@request.path.split('/') - route.path.split('/'))]
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def headers
      @response
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html' unless @response.headers
    end

    def write_response
      body = render_body
      @response.write(body)
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
      if template.is_a? String
        @request.env['simpler.template'] = template
      else
        @request.env['simpler.format'] = template.keys.first
      end
    end
  end
end
