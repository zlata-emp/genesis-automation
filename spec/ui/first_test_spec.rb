# dummy specs to show usage of tags
# see http://elementalselenium.com/tips/58-tagging for how to and more examples
#
# TODO move this info to README.md
# run rspec with -r param to sepcify which file to require used to load the environment
#
# To run this specific tests tagged with :ui for example,
#  you would specify --tag or -t and the tag name (without the :) as a runtime parameter, like so:
# rspec --tag smoke
# Alternatively, you can ignore tags with a ~ prepended to the tag name.
# rspec --tag ~smoke
# You can also tag each individual test and specify multiple tags at run time.
#
# rspec -r "./config/staging_psp.rb" -t ui
# will start all test because :ui is on the Test group
#
# rspec --tag wpf
# will start only wpf test
#
# rspec -t ~wpf
# will exclude wpf test

describe 'Test', :ui do
  it 'shows env' do
    p Environment::BASE_URL
  end

  it 'wpf', :wpf, :sanity do
    expect(0).to eq(0)
  end

  it 'sanity', :tokenization, :ui do
    expect(0).to eq(0)
  end
end
