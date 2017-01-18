require "rails_helper"

RSpec.describe ChatsController, :type => :controller do
  let!(:user) { User.create!(name: "Teste", email: "teste@teste.com.br", password: "testes") }
  let!(:live_stream1) { LiveStream.create!(title: "Teste") }

  before do
    sign_in user
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
