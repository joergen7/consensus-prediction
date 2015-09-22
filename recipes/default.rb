#
# Cookbook Name:: consensus-prediction
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

directory node.dir.wf
directory node.dir.data

# place workflow
template "#{node.dir.wf}/consensus.cf" do
  source "consensus.cf.erb"
end

