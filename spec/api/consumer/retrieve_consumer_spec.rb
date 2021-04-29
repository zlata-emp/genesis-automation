describe 'Retrieve consumer', :api, :consumer do
  let(:env) { Environment::CONSUMER }
  let(:request_file) { 'consumer/retrieve_consumer_request.xml' }
  let(:request) { PostData::Request.build_and_submit(request_file, params) }

  context 'with valid existing consumer id' do
    let(:params) { { consumer_id: env[:consumer_id] } }

    it 'returns status error' do
      expect(request.response_body_root).to include({ status: 'enabled' })
    end
  end

  context 'with valid existing email' do
    let(:params) do
      { consumer_id: nil,
        email:       env[:consumer_email]
      }
    end

    it 'returns status error' do
      p request.request_body
      expect(request.response_body_root).to include({ status: 'enabled' })
    end
  end

  context 'with erroneous request', :erroneous do
    context 'with non existing consumer_id' do
      let(:params) { { consumer_id: -1 } }

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end

    context 'with non existing email' do
      let(:params) { { email: 'non_existing_consumer@email.com' } }

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end
  end
end
