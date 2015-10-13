#
# Cookbook Name:: consensus-prediction
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::openms"
include_recipe "chef-bioinf-worker::msgf"
include_recipe "chef-bioinf-worker::omssa"
include_recipe "chef-bioinf-worker::tandem"
include_recipe "chef-bioinf-worker::blast"
include_recipe "chef-cuneiform::default"

directory node.dir.wf
directory node.dir.data

# place workflow
template "#{node.dir.wf}/consensus.cf" do
  source "consensus.cf.erb"
end

# place example data
cookbook_file "#{node.dir.data}/spectra.tar" do
  source "spectra.tar"
end

cookbook_file "#{node.dir.data}/barleyprots.fa" do
  source "barleyprots.fa"
end


