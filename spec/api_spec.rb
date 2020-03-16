# frozen_string_literal: true

describe 'API', type: :request do
  let(:app) { Application.new }

  describe 'GET /' do
    it 'returns 200 ok' do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'POST /scan' do
    it 'returns 401 unauthorized if credentials are invalid' do
      post '/scan'
      expect(last_response.status).to eq(401)
    end

    it 'returns 401 unauthorized if credentials are not given' do
      allow(ENV).to receive(:fetch).with('API_USERNAME').and_return 'username'
      allow(ENV).to receive(:fetch).with('API_PASSWORD').and_return 'password'

      token = Base64.strict_encode64('hacker:hacker')
      header 'Authorization', "Basic #{token}"

      post '/scan', {}
      expect(last_response.status).to eq(401)
    end

    context 'with valid credentials' do
      before do
        username = 'username'
        password = 'password'

        allow(ENV).to receive(:fetch).with('API_USERNAME').and_return(username)
        allow(ENV).to receive(:fetch).with('API_PASSWORD').and_return(password)

        token = Base64.strict_encode64("#{username}:#{password}")
        header 'Authorization', "Basic #{token}"

        @tempfile = Tempfile.new(%w[file .json])
        @file = Rack::Test::UploadedFile.new(@tempfile.path, 'application/json')
      end

      after { @tempfile.close! }

      it 'returns scan result (good)' do
        allow(Clamby).to receive(:safe?).and_return(true)
        post '/scan', file: @file

        expect(last_response.status).to eq(200)

        body = JSON.parse(last_response.body)
        expect(body['safe']).to eq(true)
      end

      it 'returns scan result (bad)' do
        allow(Clamby).to receive(:safe?).and_return(false)
        post '/scan', file: @file

        expect(last_response.status).to eq(200)

        body = JSON.parse(last_response.body)
        expect(body['safe']).to eq(false)
      end

      it 'returns 422 unprocessible entity if file is not given' do
        post '/scan'
        expect(last_response.status).to eq(422)
      end
    end
  end
end
