# frozen_string_literal: true

module APIRequest
  describe 'Processing bogus wpf transaction', :api, wpf: :bogus do
    request_filename = 'wpf/processing/wpf_transaction.xml'
    env_config       = Environment::WPF[:bogus]

    context 'with valid sale request' do
      request_file = Body.load_from_file(request_filename)
                         .merge_params(ProcessingHelper.transaction_types([:sale]))
                         .merge_params(ProcessingHelper.transaction_id_param)
                         .merge_params(ProcessingHelper.master_test_card_params)
                         .merge_params({ consumer_id: env_config[:consumer_id] })

      it 'is approved' do
        request = Request.build_and_submit(
                    request_file,
                    env_config: env_config
                  )

        expect(request.response_body_root).to include({ status: 'new' })

        page = Browser.reuse_page
        page.navigate.to request.response_body_root[:redirect_url]
        expect(page.title).to be == 'Genesis Secure payment form'

        Browser.fill_form_fields(
          page,
          finder:    :id,
          form_data: { wpf_form_card_holder:        'card holder',
                       wpf_form_card_number:        '5555555555554444',
                       wpf_form_expiration_date_2i: 'Nov',
                       wpf_form_expiration_date_1i: '2022',
                       wpf_form_requires_cvv:       '123' }
        ).find_element(:name, 'commit').click
        expect(page.current_url).to include 'return_success'
      end
    end
  end
end
