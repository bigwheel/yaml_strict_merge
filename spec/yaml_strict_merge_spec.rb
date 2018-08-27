RSpec.describe YamlStrictMerge do
  it "has a version number" do
    expect(YamlStrictMerge::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(YamlStrictMerge::merge()).to eq(1)
  end
end
