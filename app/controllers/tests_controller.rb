class TestsController < Simpler::Controller
  def index
    render 'tests/list'
    @time = Time.now
  end

  def create; end

  def show
    headers['Content-Type'] = 'show'
    # render 'tests/show'
    render plain: "pars in show sdfsdfsdf #{parameters[:id]}"
  end
end
