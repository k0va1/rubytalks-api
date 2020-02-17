# frozen_string_literal: true

RSpec.describe Repositories::Talk do
  subject { described_class.new(Hanami::Container[:rom]) }

  let!(:approved_talks) do
    12.times.map { Factory[:approved_talk] }
  end

  let!(:unpublished_talks) do
    3.times.map { Factory[:talk] }
  end

  let!(:declined_talks) do
    5.times.map { Factory[:declined_talk] }
  end

  describe '#find_unapproved_by_id' do
    let(:unapproved_talk_id) { unpublished_talks.last.id }

    it 'returns unapproved talk' do
      result = subject.find_unapproved_by_id(unapproved_talk_id)

      expect(result.id).to eq(unapproved_talk_id)
    end
  end

  describe '#find_approved_by_id_with_speakers_and_event' do
    subject { described_class.new.find_approved_by_id_with_speakers_and_event(approved_talk_id) }

    let(:approved_talk_id) { approved_talks.last.id }

    it 'returns approved talk' do
      expect(subject.id).to eq(approved_talk_id)
    end
  end

  describe '#find_or_create' do
    subject { described_class.new.find_or_create(talk_form) }

    context 'when talk already exists' do
      let(:talk_form) { { title: approved_talks.last.title } }

      it 'returns approved talk' do
        expect(subject.title).to eq(talk_form[:title])
      end
    end

    context 'when talk does not exist' do
      let(:talk_form) { Factory.structs[:unpublished_talk].attributes }

      it 'returns recently created talk' do
        expect(subject.id).to eq(talk_form[:id])
      end
    end
  end
end
