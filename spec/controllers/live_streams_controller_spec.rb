require "rails_helper"

RSpec.describe LiveStreamsController, :type => :controller do
  let!(:user) { User.create!(name: "Teste", email: "teste@teste.com.br", password: "testes") }
  let!(:live_stream1) { LiveStream.create!(title: "Teste") }

  before do
    sign_in user
  end

  describe "GET #index" do

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the live streams into @live_streams" do
      live_stream2 = LiveStream.create!(title: "Teste2")
      get :index

      expect(assigns(:live_streams)).to match_array([live_stream1, live_stream2])
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      get :show , params: { id: live_stream1.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, params: { id: live_stream1.id }
      expect(response).to render_template("show")
    end
  end

  describe "POST #add_chat_message" do

    before(:each) do
      request.env['HTTP_REFERER'] = live_stream_url(live_stream1)
    end

    it "responds successfully with an HTTP 302 status code" do
      post :add_chat_message , params: { live_stream_id: live_stream1.id }
      expect(response).to have_http_status(302)
    end

    it "renders the show template" do
      post :add_chat_message, params: { live_stream_id: live_stream1.id }
      expect(response).to redirect_to :back

    end
  end

end
