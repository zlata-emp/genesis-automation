describe 'Create consumer', :api, :consumer do
  let(:request_file) { 'consumer/create_consumer_request.xml' }
  let(:request) { PostData::Request.build_and_submit(request_file, params) }

  context 'with valid non existing email' do
    let(:valid_email) { "test_email_#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}@emerchantpay.com" }
    let(:params)      { { email: valid_email } }

    it 'returns status error' do
      expect(request.response_body_root).to include({ status: 'enabled' })
    end
  end

  context 'with erroneous request', :erroneous do
    context 'with existing email' do
      let(:params) { { email: 'consumer@email.com' } }

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end

    context 'without email' do
      let(:params) { { email: nil } }

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end
  end
end
