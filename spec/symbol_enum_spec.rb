require 'spec_helper'
require 'gcl/symbol_enum'

class Example < Gcl::SymbolEnum
  declare do
    item 1, :item1, 'Item 1'
    item 2, :item2, 'Item 2'
  end
end

describe Gcl::SymbolEnum do
  describe 'Version' do
    it 'is defined.' do
      expect(Gcl::SymbolEnum::VERSION).not_to be_nil
    end

    it 'is frozen.' do
      expect(Gcl::SymbolEnum::VERSION.frozen?).to be_truthy
    end
  end

  describe 'Definition' do
    it 'equals to instance of Example' do
      expect(Example.item1 == Example.item2).to be_falsey
    end

    it 'equals to Integer' do
      expect(Example.item1 == 1).to be_truthy
    end

    it 'equals to Symbol' do
      expect(Example.item1 == :item1).to be_truthy
    end

    it 'equals to String' do
      expect(Example.item1 == 'item1').to be_truthy
    end
  end

  describe 'Loader' do
    it 'loads Integer' do
      expect(Example.load(1)).to eq(Example.item1)
    end

    it 'loads Symbol' do
      expect(Example.load(:item1)).to eq(Example.item1)
    end

    it 'loads String' do
      expect(Example.load('item1')).to eq(Example.item1)
    end

    it 'loads Integer' do
      expect(Example.load(Example.first)).to eq(Example.item1)
    end
  end

  describe 'Dumper' do
    it 'dumps id' do
      expect(Example.dump(Example.item1)).to eq 1
    end
  end

  describe 'Enumerable' do
    it 'maps ids' do
      expect(Example.map(&:id)).to eq [1, 2]
    end
  end
end
