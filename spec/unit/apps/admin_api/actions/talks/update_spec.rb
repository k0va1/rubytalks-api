# frozen_string_literal: true

# TODO: restore specs, fix update action
RSpec.xdescribe AdminApi::Actions::Talks::Update do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      configuration: Hanami::Controller::Configuration.new,
      operation: operation,
      talk_repo: talk_repo,
      form: form,
      authenticator: authenticator
    )
  end
  let(:authenticator) { instance_double(AdminApi::Services::Authenticator, call: true) }

  context 'when form is valid' do
    let(:form) { double('Web::Forms::TalkForm') }

    before do
      allow(form).to receive(:call).and_return(OpenStruct.new(success?: true))
    end

    context 'when operation is success' do
      let(:talk) { Talk.new(id: 1) }
      let(:talk_repo) { Talk.new(id: 1) }
      let(:operation) { ->(*) { Success(talk) } }
      let(:params) { { id: talk.id } }

      it { expect(subject.first).to eq(302) }

      it 'redirects to dashboard' do
        subject
        expect(action.exposures[:flash][:success]).to eq('Talk has been updated')
      end
    end

    context 'when operation is not success' do
      let(:params) { { id: -100 } }
      let(:talk_repo) { Talk.new(id: 1) }
      let(:operation) { ->(*) { Failure(nil) } }

      it { expect(subject.first).to eq(302) }

      it 'redirects to dashboard' do
        subject
        expect(action.exposures[:flash][:error]).to eq('Something wrong. Talk has not been updated')
      end
    end
  end

  context 'with real data' do
    let(:action) { described_class.new }
    let!(:talk) { Fabricate.create(:talk) }
    let!(:speaker) { Fabricate.create(:speaker) }
    let(:talk_speaker) { TalksSpeakers.new(talk_id: talk.id, speaker_id: speaker.id) }
    let(:params) { { id: talk.id, talk: talk.to_h.merge(title: 'new title', speakers: [speaker.to_h]) } }

    it { expect(subject.first).to eq(302) }

    it 'redirects to dashboard' do
      subject
      expect(action.exposures[:flash][:success]).to eq('Talk has been updated')
    end
  end
end
