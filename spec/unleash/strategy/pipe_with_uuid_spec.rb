# frozen_string_literal: true

require 'unleash/context'

RSpec.describe Unleash::Strategy::PipeWithUUID do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::PipeWithUUID.new }
    let(:params) { { 'pipeUUIDs' => '1234,2567,1564' } }

    let(:unleash_context) { Unleash::Context.new({ properties: { 'pipe_uuid' => '1234' } }) }
    let(:unleash_context2) { Unleash::Context.new({ properties: { pipe_uuid: '2567' } }) }
    let(:unleash_context3) { Unleash::Context.new({ properties: { pipe_uuid: '666' } }) }

    it 'should be enabled with correct params/context as str' do
      expect(strategy.is_enabled?(params, unleash_context)).to be_truthy
    end

    it 'should be enabled with correct params/context as sym' do
      expect(strategy.is_enabled?(params, unleash_context2)).to be_truthy
    end

    it 'should not be enabled with wrong params/context' do
      expect(strategy.is_enabled?(params, unleash_context3)).to be_falsey
    end
  end
end
