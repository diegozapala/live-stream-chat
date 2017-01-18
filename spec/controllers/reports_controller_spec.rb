require "rails_helper"

RSpec.describe ReportsController, :type => :controller do
  let!(:user) { User.create!(name: "Teste", email: "teste@teste.com.br", password: "testes") }
  let!(:live_stream) { LiveStream.create!(title: "Teste") }
  let!(:report) { Report.create!(number_accesses: 5, number_messages_sent: 30, live_stream: live_stream) }

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
      report2 = Report.create!(number_accesses: 5, number_messages_sent: 30, live_stream: live_stream2)
      get :index

      expect(assigns(:reports)).to match_array([report, report2])
    end
  end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      get :show , params: { id: report.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, params: { id: report.id }, format: :json
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "POST #create" do
    context "whith valid params" do
      it "responds successfully with an HTTP 302 status code" do
        post :create, params: { "live_stream_id" => live_stream.id }
        expect(response).to have_http_status(302)
      end

      it "renders the show template" do
        post :create, params: { "live_stream_id" => live_stream.id }
        expect(response).to redirect_to "/reports/#{Report.last.id}"
      end
    end
    context "whith invalid params" do
      it "responds with an HTTP 302 status code" do
        post :create, params: { "live_stream_id" => 0 }
        expect(response).to have_http_status(302)
      end

      it "renders the show template" do
        post :create, params: { "live_stream_id" => 0 }
        expect(response).to redirect_to "/"
      end
    end
  end

end
