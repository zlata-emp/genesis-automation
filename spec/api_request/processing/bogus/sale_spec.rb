# frozen_string_literal: true

module APIRequest
  describe 'Processing bogus sale', :api, processing: :bogus do
    request_file = Body.load_from_file 'processing/sale.xml'
    env_config   = Environment::PROCESSING[:bogus]

    context 'with valid request' do
      merge_params = ProcessingHelper.transaction_id_param
                      .merge(ProcessingHelper.master_test_card_params)
      request = Request.build_and_submit(
                  request_file,
                  env_config:   env_config,
                  merge_params: merge_params
                )

      it 'is approved' do
        expect(request.response_body_root).to include({ status: 'approved' })
      end
    end
  end
end
