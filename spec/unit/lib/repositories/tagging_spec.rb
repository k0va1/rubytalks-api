# frozen_string_literal: true

RSpec.describe Repositories::Tagging do
  let(:repo) { described_class.new(Hanami::Container[:rom]) }

  describe '#find_or_create' do
    subject { repo.find_or_create(params) }

    let!(:tag) { Factory[:tag] }
    let!(:talk) { Factory[:talk] }

    let(:params) { { tag_id: tag.id, talk_id: talk.id } }

    context 'when tagging exists' do
      let!(:tagging) { Factory[:taggings, talk_id: talk.id, tag_id: tag.id] }

      it 'returns existing tagging' do
        expect { subject }.to change { repo.taggings.count }.by(0)
        expect(subject.id).to eq(tagging.id)
      end
    end

    context 'when tagging does not exist' do
      it 'creates and returns new tagging' do
        expect { subject }.to change { repo.taggings.count }.by(1)
        expect(subject.tag_id).to eq(tag.id)
      end
    end
  end
end
