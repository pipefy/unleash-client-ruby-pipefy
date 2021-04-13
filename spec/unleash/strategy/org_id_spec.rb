require 'unleash/context'

RSpec.describe Unleash::Strategy::OrgId do
  it 'has a version number' do
    expect(Unleash::Strategy::OrgId::VERSION).not_to be nil
  end


  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::OrgId.new }
    let(:unleash_context) { Unleash::Context.new({ properties: { 'org_id' => '1234' } }) }

    it 'should be enabled with correct params/context as str' do
      expect(strategy.is_enabled?({ 'orgIds' => '1234, 2567, 1564' }, unleash_context)).to be_truthy
    end

    it 'should be enabled with correct params/context as sym' do
      unleash_context2 = Unleash::Context.new({ properties: { org_id: '2567' } })
      expect(strategy.is_enabled?({ 'orgIds' => '1234, 2567, 1564' }, unleash_context2)).to be_truthy
    end

    it 'should not be enabled with wrong params/context' do
      unleash_context2 = Unleash::Context.new({ properties: { 'org_id' => '666' } })
      expect(strategy.is_enabled?({ 'orgIds' => '1234, 2567, 1564' }, unleash_context2)).to be_falsey
    end
  end
end
