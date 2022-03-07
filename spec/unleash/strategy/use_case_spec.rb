# frozen_string_literal: true

require 'unleash/context'

RSpec.describe Unleash::Strategy::UseCase do
  describe '#is_enabled?' do
    let(:strategy) { Unleash::Strategy::UseCase.new }
    let(:params) { { 'Experience' => '{"Sales": ["Lead Qualification"]}' } }
    let(:unleash_context) do
      Unleash::Context.new({ properties: { experience: { department: 'Sales', use_case: 'Lead Qualification ' } } })
    end
    let(:unleash_context2) do
      Unleash::Context.new({ properties: { experience: { department: 'Human Resources',
                                                         use_case: 'Employee Onboarding' } } })
    end

    it 'should be enabled with correct params/context as str' do
      expect(strategy.is_enabled?(params, unleash_context)).to be_truthy
    end

    it 'should not be enabled with wrong params/context' do
      expect(strategy.is_enabled?(params, unleash_context2)).to be_falsey
    end
  end
end
