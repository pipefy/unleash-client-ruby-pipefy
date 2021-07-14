# frozen_string_literal: true

require 'unleash/context'

RSpec.describe Unleash::Strategy::EmailFromDomain do
  let(:unleash_context) { Unleash::Context.new(properties: { email: email }) }

  describe '#is_enabled?' do
    subject { described_class.new.is_enabled?({ 'domains' => ['active.com'] }, unleash_context) }

    context 'when the email is blank' do
      let(:email) { nil }
      it { is_expected.to be_falsey }
    end

    context 'when the email is invalid' do
      let(:email) { 'my.own' }
      it { is_expected.to be_falsey }
    end

    context 'when the email is valid' do
      context 'when the domain is not enabled' do
        let(:email) { 'my@personal.net' }
        it { is_expected.to be_falsey }
      end

      context 'when the domain is enabled' do
        let(:email) { 'my@active.com' }
        it { is_expected.to be_truthy }
      end
    end
  end
end
