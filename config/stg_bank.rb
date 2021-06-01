# frozen_string_literal: true

require './config/config'

class Environment < Config
  WPF = {
    omnipay: {
      processing_url: 'https://staging.wpf.e-comprocessing.net/wpf',
      consumer_id:    '34109',
      consumer_email: 'travis@example.com',
      api_login:      '0a865f0684affcada493aeb9768be0eb22c92a41',
      api_password:   'fs90HFftOJgGp6CAm14UzhHJtwVm7LUU14QgsXVp' } }.with_indifferent_access.freeze
end

require './config/config_rspec'
