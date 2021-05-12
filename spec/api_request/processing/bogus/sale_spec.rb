# frozen_string_literal: true

module APIRequest
  describe 'Processing bogus sale', :api, processing: :bogus do
    request_filename = 'processing/sale.xml'
    env_config       = Environment::PROCESSING[:bogus]

    context 'with valid request' do
      request_file = Body.load_from_file(request_filename)
                       .merge_params(ProcessingHelper.transaction_id_param)
                       .merge_params(ProcessingHelper.master_test_card_params)

      it 'is approved' do
        request = Request.build_and_submit(
                    request_file,
                    env_config: env_config
                  )

        expect(request.response_body_root).to include({ status: 'approved' })
      end
    end

    context 'with valid 3d async request' do
      request_filename = 'processing/async_sale3d.xml'
      request_file = Body.load_from_file(request_filename)
                       .merge_params(ProcessingHelper.transaction_id_param)
                       .merge_params(ProcessingHelper.visa_test_card_3d_async_params)

      it 'is approved' do
        request = Request.build_and_submit(
                    request_file,
                    env_config: env_config
                  )

        expect(request.response_body_root).to include({ status: 'pending_async' })

        expect do
          Browser.submit_form(
            request.response_body_root[:redirect_url],
            { password: 'pass' }
          )
        end.to raise_error(Mechanize::ResponseCodeError, %r{example.com/success})
      end
    end
  end
end
