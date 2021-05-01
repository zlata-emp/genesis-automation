# frozen_string_literal: true

module APIRequest
  describe 'Retrieve consumer', :api, :consumer do
    request_file = Body.load_from_file 'consumer/retrieve_consumer_request.xml'
    env_config   = Environment::CONSUMER

    context 'with valid existing consumer id' do
      it 'returns status enabled' do
        request = Request.build_and_submit(
                    request_file,
                    env_config:   env_config,
                    merge_params: { consumer_id: Environment::CONSUMER[:consumer_id] }
                  )

        expect(request.response_body_root).to include({ status: 'enabled' })
      end
    end

    context 'with valid existing email' do
      it 'returns status enabled' do
        request = Request.build_and_submit(
                    request_file,
                    env_config:   env_config,
                    merge_params: { consumer_id: nil,
                                    email:       Environment::CONSUMER[:consumer_email] }
                  )

        expect(request.response_body_root).to include({ status: 'enabled' })
      end
    end

    context 'with erroneous request', :erroneous do
      context 'with non existing consumer_id' do
        it 'returns status error' do
          request = Request.build_and_submit(
                      request_file,
                      env_config:   env_config,
                      merge_params: { consumer_id: -1 }
                    )

          expect(request.response_body_root).to include({ status: 'error' })
        end
      end

      context 'with non existing email' do
        it 'returns status error' do
          request = Request.build_and_submit(
                      request_file,
                      env_config:   env_config,
                      merge_params: { consumer_id: nil,
                                      email:       'non_existing_consumer@email.com' }
                    )

          expect(request.response_body_root).to include({ status: 'error' })
          expect(request.response_body_root).to include({ technical_message: 'Consumer not found!' })
        end
      end
    end
  end
end
