require './project1-caesar.rb'

describe "#caesar_cipher" do
  it "basic string" do
    expect(caesar_cipher('abcd', 1)).to eql('bcde')
  end
  it "string with space" do
    expect(caesar_cipher('abcd efgh')).to eql('bcde fghi')
  end
  it "wrap test" do
    expect(caesar_cipher('z')).to eql('a')
  end
  it "ignore numbers" do
    expect(caesar_cipher('ab1cd')).to eql('bc1de')
  end
end
