require 'spec_helper'
describe 'dns' do

  context 'with defaults for all parameters' do
    it { should contain_class('dns') }
  end
end
