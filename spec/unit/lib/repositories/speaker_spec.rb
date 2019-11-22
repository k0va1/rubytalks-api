# frozen_string_literal: true

RSpec.describe Repositories::Speaker do
  subject { described_class.new(Hanami::Container[:rom]) }

  describe '#find_by_name' do
    let!(:speaker1) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Koval')
      )
    end

    let!(:speaker2) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Korn')
      )
    end

    let!(:speaker3) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Jorge', last_name: 'Martin')
      )
    end

    context 'when record exists' do
      it 'returns existing record' do
        result = subject.find_by_name(first_name: 'Alex', last_name: 'Koval')

        expect(result.first_name).to eq(speaker1.first_name)
      end
    end

    context 'when record does not exist' do
      it 'returns nil' do
        result = subject.find_by_name(first_name: 'Steve', last_name: 'Voznyak')

        expect(result).to be_nil
      end
    end
  end

  describe '#order_by_last_name' do
    let!(:speaker1) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Koval')
      )
    end
    let!(:speaker2) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Jorge', last_name: 'Martin')
      )
    end

    let!(:speaker3) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Bob', last_name: 'Martin')
      )
    end

    let!(:speaker4) do
      subject.create(
        Factory.structs[:speaker].attributes.merge(first_name: 'Cat', last_name: 'Simmons')
      )
    end

    context 'without order param' do
      it 'returns speakers ordered by name asc' do
        result = subject.order_by_last_name

        expect(result.map(&:first_name)).to eq([speaker1, speaker3, speaker2, speaker4].map(&:first_name))
      end
    end

    context 'with desc order param' do
      it 'returns speakers ordered by name desc' do
        result = subject.order_by_last_name(order: :desc)

        expect(result.map(&:first_name)).to eq([speaker4, speaker3, speaker2, speaker1].map(&:first_name))
      end
    end
  end

  describe '#find_with_talks' do
    let!(:unapproved_speakers) do
      5.times.map { Factory[:speaker] }
    end

    let(:approved_speakers) do
      5.times.map { Factory[:approved_speaker] }
    end

    let(:approved_speaker_id) { approved_speakers.last.id }

    it 'returns speaker by id' do
      result = subject.find_with_talks(id: approved_speaker_id)

      expect(result).to be_kind_of(ROM::Struct::Speaker)
      expect(result.id).to eq(approved_speaker_id)
    end
  end

  describe '#all_approved' do
    let!(:unapproved_speakers) do
      5.times.map { Factory[:speaker] }
    end

    let!(:approved_speakers) do
      6.times.map { Factory[:approved_speaker] }
    end

    it 'returns all approved speakers' do
      result = subject.all_approved

      expect(result.length).to eq(6)
      expect(result.map(&:id)).to match_array(approved_speakers.map(&:id))
    end
  end
end
