# frozen_string_literal: true

module APIRequest
  describe 'Create consumer', :api, :consumer do
    request_file = Body.load_from_file 'consumer/create_consumer_request.xml'
    env_config   = Environment::CONSUMER

    context 'with valid non existing email' do
      valid_email = "test_email_#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}@emerchantpay.com"

      it 'returns status enabled' do
        request = Request.build_and_submit(
                    request_file,
                    env_config:   env_config,
                    merge_params: { email: valid_email }
                  )

        expect(request.response_body_root).to include({ status: 'enabled' })
      end
    end

    context 'with erroneous request', :erroneous do
      context 'with existing email' do
        it 'returns status error' do
          request = Request.build_and_submit(
                      request_file,
                      env_config:   env_config,
                      merge_params: { email: Environment::CONSUMER[:consumer_email] }
                    )
          expect(request.response_body_root).to include({ status: 'error' })
        end
      end

      context 'without email' do
        it 'returns status error' do
          request = Request.build_and_submit(
                      request_file,
                      env_config:   env_config,
                      merge_params: { email: nil }
                    )
          expect(request.response_body_root).to include({ status: 'error' })
        end
      end
    end
  end
end
