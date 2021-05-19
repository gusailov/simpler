require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    response = Rack::Response.new
    request = "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
    # Handler: TestsController#index
    # Parameters: {'category' => 'Backend'}
    # Response: 200 OK [text/html] tests/index.html.erb
    @logger.info(request)
    @logger.info(response)
    @app.call(env)
  end
end
