# frozen_string_literal: true

module APIRequest
  describe 'Processing bogus wpf transaction', :api, wpf: :bogus do
    request_filename = 'wpf/processing/wpf_transaction.xml'
    env_config       = Environment::WPF[:omnipay]

    context 'with valid sale3d request' do
      request_file = Body.load_from_file(request_filename)
                         .merge_params(ProcessingHelper.transaction_types([:sale3d]))
                         .merge_params(ProcessingHelper.transaction_id_param)
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
          form_data: ProcessingHelper.wpf_card_params(card_number: '4711100000000000')
        ).find_element(:name, 'commit').click

        binding.pry
        expect(page.current_url).to include 'return_success'
      end
    end

    context 'with valid authorize3d request' do
      request_file = Body.load_from_file(request_filename)
                         .merge_params(ProcessingHelper.transaction_types([:authorize3d]))
                         .merge_params(ProcessingHelper.transaction_id_param)
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
          form_data: ProcessingHelper.wpf_card_params(card_number: '4711100000000000')
        ).find_element(:name, 'commit').click
        binding.pry
        expect(page.current_url).to include 'return_success'
      end
    end

    context 'with valid init_recuring_sale3d request' do
      request_file = Body.load_from_file(request_filename)
                         .merge_params(ProcessingHelper.transaction_types([:init_recurring_sale3d]))
                         .merge_params(ProcessingHelper.transaction_id_param)
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
          form_data: ProcessingHelper.wpf_card_params(card_number: '4711100000000000')
        ).find_element(:name, 'commit').click
        expect(page.current_url).to include 'return_success'
      end
    end
  end
end
