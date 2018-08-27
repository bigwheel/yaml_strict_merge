RSpec.describe YamlStrictMerge do
  it "has a version number" do
    expect(YamlStrictMerge::VERSION).not_to be nil
  end

  it "merge simple shallow objects" do
    expect(YamlStrictMerge::merge_yaml(<<~LHS, <<~RHS)).to eq(<<~EXPECT)
      a: 1
    LHS
      b: 2
    RHS
      ---
      a: 1
      b: 2
    EXPECT
  end
  it "merge objects recursively" do
    expect(YamlStrictMerge::merge_yaml(<<~LHS, <<~RHS)).to eq(<<~EXPECT)
      a:
        f: 1
        h: 3
    LHS
      a:
        f: 1
        g: 2
    RHS
      ---
      a:
        f: 1
        h: 3
        g: 2
    EXPECT
  end
  it "throw exception when objects conflict" do
    expect { YamlStrictMerge::merge_yaml(<<~LHS, <<~RHS) }.to raise_error(YamlStrictMerge::YamlMergeError)
      a: 1
    LHS
      a: 2
    RHS
  end
  it "merge same arrays" do
    expect(YamlStrictMerge::merge_yaml(<<~LHS, <<~RHS)).to eq(<<~EXPECT)
      - 1
      - 2
    LHS
      - 1
      - 2
    RHS
      ---
      - 1
      - 2
    EXPECT
  end
  it "doesn't merge different length arrays" do
    expect { YamlStrictMerge::merge_yaml(<<~LHS, <<~RHS) }.to raise_error(YamlStrictMerge::YamlMergeError)
      - 1
      - 2
    LHS
      - 1
      - 2
      - 3
    RHS
  end
end
