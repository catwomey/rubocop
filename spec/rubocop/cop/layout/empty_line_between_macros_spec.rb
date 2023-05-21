# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Layout::EmptyLineBetweenMacros, :config do
  let(:cop_config) { RuboCop::Config.new }

  context 'IncludedMacros: [\'test\']' do
    let(:cop_config) { { 'IncludedMacros' => ['test']}}

    it 'registers offense' do
      expect_offense(<<~RUBY)
        test 'first test' do
          assert_true true
        end
        test 'second test' do
        ^^^^^^^^^^^^^^^^^^^^^ Expected 1 empty line between Macros; found 0.
          assert_true true
        end
      RUBY
      expect_correction(<<~RUBY)
        test 'first test' do
          assert_true true
        end

        test 'second test' do
          assert_true true
        end
      RUBY
    end



    it 'does not register offense for non registered macro names' do
      expect_no_offenses(<<~RUBY)
        foo :bar  
        test 'first test' do
          assert_true true
        end
        blah :thinger
        sig {void}
        test 'second test' do
          assert_true true
        end
      RUBY
    end
  end
  context 'IncludedMacros: []' do
    it 'does not register offense' do
      expect_no_offenses(<<~RUBY)
        test 'first test' do
          assert_true true
        end
        test 'second test' do
          assert_true true
        end
      RUBY
    end
  end
end
