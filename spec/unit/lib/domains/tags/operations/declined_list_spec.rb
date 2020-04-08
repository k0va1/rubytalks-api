# frozen_string_literal: true

RSpec.describe Domains::Tags::Operations::DeclinedList do
  subject { operation.call(input) }

  let(:declined_tags) { 3.times.map { Factory.structs[:tag, state: 'declined'] } }
  let(:tag_repo) { instance_double(Repositories::Tag, all_declined: declined_tags) }
  let(:operation) { described_class.new(tag_repo: tag_repo) }
  let(:input) { {} }

  context 'tags exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'there are no tags' do
    let(:tag_repo) { instance_double(Repositories::Tag, all_declined: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end
end
