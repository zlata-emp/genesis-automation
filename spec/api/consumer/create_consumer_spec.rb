# frozen_string_literal: true

describe 'Create consumer', :api, :consumer do
  request_file = 'consumer/create_consumer_request.xml'

  context 'with valid non existing email' do
    valid_email  = "test_email_#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}@emerchantpay.com"
    request      = PostData::Request.build_and_submit(
                     request_file,
                     { email: valid_email }
                   )

    it 'returns status error' do
      expect(request.response_body_root).to include({ status: 'enabled' })
    end
  end

  context 'with erroneous request', :erroneous do
    context 'with existing email' do
      request = PostData::Request.build_and_submit(
                  request_file,
                  { email: Environment::CONSUMER[:consumer_email] }
                )

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end

    context 'without email' do
      request = PostData::Request.build_and_submit(
                  request_file,
                  { email: nil }
                )

      it 'returns status error' do
        expect(request.response_body_root).to include({ status: 'error' })
      end
    end
  end
end
