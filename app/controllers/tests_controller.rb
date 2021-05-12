class TestsController < Simpler::Controller
  def index
    status 201
    render plain: 'Plain text response'
    headers['Content-Type'] = 'text/plainfdsfdsfsdf'
    headers['X-ComanyName-Api-Version'] = 'V1'
    headers['X-ComanyNam'] = 'Vdfdfff'
    @time = Time.now
  end

  def create; end
end
