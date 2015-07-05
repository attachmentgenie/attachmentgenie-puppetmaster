require 'spec_helper'
describe 'puppetmaster::stack_puppetmaster' do
  let :facts do
  {
    :concat_basedir         => '/tmp',
    :interfaces             => '',
    :lsbdistid              => 'Debian',
    :operatingsystem        => 'Debian',
    :operatingsystemrelease => 'wheezy',
    :osfamily               => 'Debian',
  }
  end

  context 'with defaults for all parameters' do
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
    end
  end

  context 'activemq enabled' do
    let(:params) { {:activemq => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_activemq')
    end
  end

  context 'foreman enabled' do
    let(:params) { {:foreman => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_foreman')
    end
  end

  context 'puppetmaster and foreman_proxy enabled' do
    let(:params) { {:foreman_proxy => true, :puppetmaster => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_foreman_proxy')
    end
  end

  context 'mcollective enabled' do
    let(:params) { {:mcollective => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_mcollective')
    end
  end

  context 'mcollective and mcollective_r10k enabled' do
    let(:params) { {:mcollective => true, :mcollective_r10k => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_mcollective_r10k')
    end
  end

  context 'puppetdb enabled' do
    let(:params) { {:puppetdb => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_puppetdb')
    end
  end

  context 'r10k enabled' do
    let(:params) { {:r10k => true} }
    it { should compile }
    it do
      should contain_class('puppetmaster::profile_puppet')
      should contain_class('puppetmaster::profile_r10k')
    end
  end
end
