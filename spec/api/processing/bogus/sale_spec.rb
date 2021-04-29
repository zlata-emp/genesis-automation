# frozen_string_literal: true

describe 'Processing bogus sale', :api, processing: :bogus do
  request_file = 'processing/sale.xml'
  env_config   = Environment::PROCESSING[:bogus]

  context 'with valid request' do
    request = PostData::Request.build_and_submit(
                request_file,
                env_config:   env_config,
                merge_params: { transaction_id: ProcessingHelper.transaction_id }
              )

    it 'is approved' do
      expect(request.response_body_root).to include({ status: 'approved' })
    end
  end
end
