# frozen_string_literal: true

module APIRequest
  describe 'Processing bogus sale', :api, processing: :bogus do
    request_filename = 'processing/sale.xml'
    env_config       = Environment::PROCESSING[:bogus]

    context 'with valid request' do
      request_file = Body.load_from_file(request_filename)
                       .merge_params(ProcessingHelper.transaction_id_param)
                       .merge_params(ProcessingHelper.master_test_card_params)
      request = Request.build_and_submit(
                  request_file,
                  env_config: env_config
                )

      it 'is approved' do
        expect(request.response_body_root).to include({ status: 'approved' })
      end
    end
  end
end
