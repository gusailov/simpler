class TestsController < Simpler::Controller
  def index
    render 'tests/list'
    @time = Time.now
  end

  def create; end

  def show
    render plain: "pars in show sdfsdfsdf #{parameters[:id]}"
  end
end
