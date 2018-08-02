require "spec_helper"

RSpec.describe Game do
  it "has a version number" do
    expect(Game::VERSION).not_to be nil
  end

  it "defines the module" do
    expect(defined?(Game)).to be_truthy
  end
end

RSpec.describe Game::Point do
  it "correct starting point" do
    expect(Game::Point.point).to be 0
  end

  it "can increase point by 1" do
    (1..5).each do |i|
      Game::Point.increase
      expect(Game::Point.point).to be i
    end
  end
end

RSpec.describe Game::Level do
  it "correct starting level" do
    expect(Game::Level.level).to be 1
  end

  it "can increase level by 1" do
    (1..5).each do |i|
      expect(Game::Level.level).to be i
      Game::Level.increase
    end
  end
end
