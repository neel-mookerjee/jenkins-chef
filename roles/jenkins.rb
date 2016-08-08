name 'jenkins'
description 'set up jenkins for this project'
default_attributes(
)
run_list(
    'recipe[jenkins-setup::default]',
    'recipe[jenkins-setup::setup_plugins]',
    'recipe[jenkins-setup::setup_build_jobs]',
    'recipe[jenkins-setup::setup_artifact_jobs]'
)
