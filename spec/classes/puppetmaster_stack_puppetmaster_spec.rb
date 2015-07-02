require 'spec_helper'
describe 'puppetmaster::stack_puppetmaster' do

  let :facts do
  {
   :concat_basedir         => '/tmp',
   :osfamily               => 'debian',
   :operatingsystemrelease => 'wheezy'
  }
  end
  context 'with defaults for all parameters' do
    it { should contain_class('puppetmaster::stack_puppetmaster') }
  end
end
