require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)

    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    # Response: 200 OK [text/html] tests/index.html.erb
    @logger.info("Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}")
    @app.call(env)
    controller = env['simpler.controller']

    @logger.info("Handler: #{controller.class.name}##{env['simpler.action']}")
    @logger.info("Parameters: #{request.params}")
    @logger.info("Response: #{controller.response.status}, #{controller.response['Content-Type']}, #{env['simpler.template_path']}")
    @app.call(env)
  end
end
