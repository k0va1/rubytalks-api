# frozen_string_literal: true

RSpec.describe Repositories::Tag do
  let(:repo) { described_class.new(Hanami::Container[:rom]) }

  describe '#find_by_slug' do
    subject { repo.find_by_slug(slug) }

    let!(:tag1) { Factory[:tag] }
    let!(:tag2) { Factory[:tag] }
    let!(:tag3) { Factory[:tag] }

    context 'when tag exists' do
      let(:slug) { tag2.slug }

      it 'returns tag by its slug' do
        expect(subject).to eq(tag2)
      end
    end
  end

  describe '#unique_slug?' do
    subject { repo.unique_slug?(slug) }

    context 'when uniq' do
      let!(:tag) { Factory[:tag] }
      let(:slug) { 'new-slug' }

      it { is_expected.to eq(true) }
    end

    context 'when is not uniq' do
      let!(:tag) { Factory[:tag] }
      let(:slug) { tag.slug }

      it { is_expected.to eq(false) }
    end
  end

  describe '#create' do
    subject { repo.create(args) }

    let(:args) { Factory.structs[:tag].attributes }

    it 'creates new tag' do
      expect(subject.slug).to eq(args[:slug])
    end
  end
end
