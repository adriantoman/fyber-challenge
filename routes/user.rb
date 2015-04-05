class MyApp < Sinatra::Base
  before do
    @flash = session.delete(:flash)
  end

  get '/' do
    erb :index
  end


end
