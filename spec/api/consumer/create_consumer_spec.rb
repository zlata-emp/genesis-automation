describe 'Create consumer', :api, :consumer do
  context 'with valid non existing email' do
    let(:request_file) { 'consumer/create_consumer_request.xml' }
    let(:valid_email)  { "test_email_#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}@emerchantpay.com" }
    let(:request)      { PostData::Request.build_and_submit(request_file, { email: valid_email }) }

    it 'returns status error' do
      expect(request.response_body_root).to include({ status: 'enabled' })
    end
  end

  context 'with erroneous request', :erroneous do
    context 'with existing email' do
      request = PostData::Request.build_and_submit('consumer/create_consumer_request.xml',
                                                   { email: Environment::CONSUMER[:consumer_email] })
      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end

    context 'without email' do
      it 'returns status error' do
        request = PostData::Request.build_and_submit('consumer/create_consumer_request.xml',
                                                     { email: nil })

        expect(request.response_body_root).to include({ status: 'error' })
      end
    end
  end
end
