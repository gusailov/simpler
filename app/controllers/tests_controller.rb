class TestsController < Simpler::Controller
  def index
    status 404
    render 'tests/list'
    render plain: 'Plain text response'
    headers['Content-Type'] = 'text/plainfdsfdsfsdf'
    headers['X-ComanyName-Api-Version'] = 'V1'
    headers['X-ComanyNam'] = 'Vdfdfff'
    @time = Time.now
  end

  def create; end

  def show
    headers['Content-Type'] = 'show'
    # render 'tests/show'
    # render plain: "pars in show #{parameters[:id]}"
  end
end
