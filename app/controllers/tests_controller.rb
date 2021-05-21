class TestsController < Simpler::Controller
  def index
    @time = Time.now
  end

  def create; end

  def show
    headers['Content-Type'] = 'show'
    # render 'tests/show'
    render plain: "pars in show #{parameters[:id]}"
  end
end
