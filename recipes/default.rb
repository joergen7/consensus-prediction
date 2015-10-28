# coding: utf-8
#
# Cookbook Name:: consensus-prediction
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


spectra_id_set = ["NUNP1", "NUNP2", "ORG1", "ORG2"]
spectra_dir = "#{node.dir.data}/spectra"

pep_id_set = ["abinitio", "all"]
pep_dir = "#{node.dir.data}/pep"


include_recipe "chef-bioinf-worker::openms"
include_recipe "chef-bioinf-worker::msgf"
include_recipe "chef-bioinf-worker::omssa"
include_recipe "chef-bioinf-worker::tandem"
include_recipe "chef-bioinf-worker::blast"
include_recipe "chef-cuneiform::default"

directory node.dir.wf
directory node.dir.data
directory spectra_dir
directory pep_dir

# place workflow
template "#{node.dir.wf}/consensus.cf" do
  source "consensus.cf.erb"
end


# download mgf spectra
spectra_id_set.each { |id|

  link = "http://www.ebi.ac.uk/pride/data/archive/2015/08/PXD001933/#{id}.mgf"
  file = "#{spectra_dir}/#{File.basename( link )}"

  remote_file file do
    action :create_if_missing
    source link
    retries 1
  end

}

# download peptide sequences
pep_id_set.each { |id|

  link = "ftp://ftp.ensembl.org/pub/release-82/fasta/homo_sapiens/pep/Homo_sapiens.GRCh38.pep.#{id}.fa.gz"
  file = "#{pep_dir}/#{File.basename( link )}"

  remote_file file do
    action :create_if_missing
    source link
    retries 1
  end

}

# create links to xml files
link "#{node.dir.data}/mods.xml" do
  to "./omssa-2.1.9.linux/mods.xml"
end

link "#{node.dir.data}/usermods.xml" do
  to "./omssa-2.1.9.linux/usermods.xml"
end
