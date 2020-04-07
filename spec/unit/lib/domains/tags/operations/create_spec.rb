# frozen_string_literal: true

RSpec.describe Domains::Tags::Operations::Create do
  subject { operation.call(params) }

  let(:operation) { described_class.new(tag_repo: tag_repo, slug_generator: slug_generator) }

  context 'with mocks' do
    let(:slug_generator) { instance_double(Util::SlugGenerator, call: 'slug') }
    let(:tag_repo) { instance_double(Repositories::Tag, create: tag, unique_slug?: true) }

    let(:tag) { Factory.structs[:tag] }
    let(:params) { tag.attributes }

    it 'successfuly creates new tag' do
      is_expected.to be_success
      expect(subject.value!.title).to eq(tag.title)
    end

    context 'when tag already exists' do
      let(:tag_repo) { instance_double(Repositories::Tag, create: tag, unique_slug?: false) }

      it 'successfuly creates new tag' do
        is_expected.to be_failure
        expect(subject.failure).to eq('tag with this slug already exists')
      end
    end
  end
end
