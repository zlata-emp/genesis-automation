# dummy specs to show usage of tags
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
