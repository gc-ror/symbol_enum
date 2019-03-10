# frozen_string_literal: true

require 'spec_helper'
# noinspection RubyResolve
require 'gcl/symbol_enum'

class Model
  # Dummy scope implementation
  def self.scope(name, proc)
  end

  # Dummy serialize implementation
  def self.serialize(attribute, type)
    attr_accessor attribute
  end
end


class ExampleModel < Model
  class ExampleValue < Gcl::SymbolEnum::Value
    item 1, :item1, 'Item 1'
    item 2, :item2, 'Item 2'
    item 3, :item3, 'Item 3'

    group :group1, %i[item1 item2]
  end

  extend Gcl::SymbolEnum::Binding
  bind_enum_field :example, ExampleValue
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
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.item1 == ExampleModel::ExampleValue.item2).to be_falsey
    end

    it 'equals to Integer' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.item1 == 1).to be_truthy
    end

    it 'equals to Symbol' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.item1 == :item1).to be_truthy
    end

    it 'equals to String' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.item1 == 'item1').to be_truthy
    end
  end

  describe 'Loader' do
    it 'loads Integer' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.load(1)).to eq(ExampleModel::ExampleValue.item1)
    end

    it 'loads Symbol' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.load(:item1)).to eq(ExampleModel::ExampleValue.item1)
    end

    it 'loads String' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.load('item1')).to eq(ExampleModel::ExampleValue.item1)
    end

    it 'loads Integer' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.load(ExampleModel::ExampleValue.first)).to eq(ExampleModel::ExampleValue.item1)
    end
  end

  describe 'Dumper' do
    it 'dumps id' do
      # noinspection RubyResolve
      expect(ExampleModel::ExampleValue.dump(ExampleModel::ExampleValue.item1)).to eq 1
    end
  end

  describe 'Enumerable' do
    it 'maps ids' do
      expect(ExampleModel::ExampleValue.map(&:id)).to eq [1, 2, 3]
    end
  end

  describe 'Group' do
    it 'return true if it includes item' do
      expect(ExampleModel::ExampleValue.group1 === ExampleModel::ExampleValue.item1).to be_truthy
    end

    it 'return false if it does not include item' do
      expect(ExampleModel::ExampleValue.group1 === ExampleModel::ExampleValue.item3).to be_falsey
    end
  end

  describe 'Attributes' do
    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(1)
      expect(m.example == ExampleModel::ExampleValue.item1).to be_truthy
    end

    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(3)
      expect(m.example == ExampleModel::ExampleValue.item1).to be_falsey
    end

    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(1)
      expect(m.example_item1?).to be_truthy
    end

    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(3)
      expect(m.example_item1?).to be_falsey
    end

    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(1)
      expect(m.example_group1?).to be_truthy
    end

    it 'equals to value' do
      m = ExampleModel.new
      m.example = ExampleModel::ExampleValue.load(3)
      expect(m.example_group1?).to be_falsey
    end

  end
end
