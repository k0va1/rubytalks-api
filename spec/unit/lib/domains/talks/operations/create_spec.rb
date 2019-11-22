# frozen_string_literal: true

RSpec.describe Domains::Talks::Operations::Create do
  subject { operation.call(talk_form) }

  let(:oembed) { class_double(OEmbed::Providers) }

  let(:talk_form) do
    Factory.structs[:talk].attributes.merge(
      speakers: [Factory.structs[:speaker].attributes],
      event: Factory.structs[:event].attributes,
      talk: Factory.structs[:talk].attributes
    )
  end

  context 'with real data' do
    before do
      allow(oembed).to receive(:get).and_return(OpenStruct.new(html: '<iframe width="100%" height="300px" src="https://www.youtube.com/embed/0nc3SXoObs8" frameborder="0" allowfullscreen></iframe>')) # rubocop: disable Metrics/LineLength
    end

    let(:operation) { described_class.new(oembed: oembed) }

    it { expect(subject).to be_success }
  end
end
