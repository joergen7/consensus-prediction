name             'consensus-prediction'
maintainer       "Jörgen Brandt"
maintainer_email "brandjoe@hu-berlin.de"
license          'all_rights'
description      'Installs/Configures consensus-prediction'
long_description 'Installs/Configures consensus-prediction'
version          '0.1.0'

recipe "consensus-prediction::_common", "Performs an update of the package system."
recipe "consensus-prediction::default", "Sets up all preconditions to run the consensus prediction workflow."


depends "chef-bioinf-worker"
depends "chef-cuneiform"
