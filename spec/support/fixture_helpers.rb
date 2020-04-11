# frozen_string_literal: true

module FixtureHelpers
  def fixtures_path
    File.join(Hanami.root, 'spec', 'support', 'fixtures')
  end
end
