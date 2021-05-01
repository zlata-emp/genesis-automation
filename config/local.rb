# frozen_string_literal: true

class Environment
  REQUESTS_DIR = 'requests'

  UI = {
    login_url: 'http://127.0.0.1:3000/admin_users/sign_in' }.with_indifferent_access.freeze

  # disable mail checks on local, because it doesn't send mails but opens temp file only
  # MAIL = {
  #   address:     'genesis.test.automation@gmail.com',
  #   subject:     'emerchantpay.com lost password',
  #   from:        'admin@emerchantpay.com',
  #   retries:     3,
  #   retry_sleep: 1 }.with_indifferent_access.freeze

  CONSUMER = {
    processing_url: 'http://127.0.0.1:3001/v1',
    api_login:      'dea4917c5fc30ba004935b852746982b69dd280e',
    api_password:   'wI0sZpoglALEwjczLG0YzDHfMrpM48hEflbYcC7O',
    consumer_id:    1,
    consumer_email: 'no_reply@emerchantpay.com' }.with_indifferent_access.freeze

  # Example how the config from sanity checks may look as ruby constant

  # WPF = {
  #   processing_url: 'http://127.0.0.1:3003',
  #   gateways: %w[omnipay]
  # }.with_indifferent_access.freeze

  # ISSUING = {
  #   processing_url: 'http://127.0.0.1:3001/v1/issuing',
  #   processing_token: 'A-HkhdnM4dgXN4ukUmstGrD00Q7ZjKKbw-aCRGBI18g',
  #   processing_providers: [paynetics, ppro, transact, gps]
  # }.with_indifferent_access.freeze

  # TOKENIZATION = {
  #   processing_url: 'http://127.0.0.1:3001/v1',
  #   consumer_id: 2,
  #   consumer_email: 'no_reply@emerchantpay.com',
  #   api_login: '846ff9581b9a999669787d3a4f9eee54200fd3ae',
  #   api_password: 'e,,9DV80eBRpyKXBD,anwFxWfdArop8RJ3JhpesX'
  # }.with_indifferent_access.freeze

  PROCESSING = {
    bogus: {
      processing_url: 'http://127.0.0.1:3001/process',
      # name:           'bogus_terminal',
      # request_params: {
      #   consumer_id:          1,
      #   credit_card_token:    {
      #     visa:         'a82c99ec-cef4-4f95-91b9-366ae3b87b2c',
      #     master:       '635459bf-3d34-4e60-9426-9c067bfd3e22',
      #     intl_maestro: 'd4c59a2a-baf0-498c-9a62-8548dafde693' },
      #   credit_card_token_id: {
      #     visa:   'ea94fc32ab31193871fa4f123618aa19',
      #     master: 'e467188059d01d1b2263190a02caa28a' } } ,
      token:          'caffe33f9faec0f798739cd19ab785177e4669a2',
      api_login:      'dea4917c5fc30ba004935b852746982b69dd280e',
      api_password:   'wI0sZpoglALEwjczLG0YzDHfMrpM48hEflbYcC7O' } }.with_indifferent_access.freeze
end
