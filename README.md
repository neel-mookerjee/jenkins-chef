# Jenkins Chef
Infrastructure scripts for setting up environment and create Jenkins job for building, testing, producing and deploying artifacts

## Run scripts
---
* On the VM, `cd jenkins-chef`
* Get the latest as and when required - `git pull`
* `berks install && berks vendor cookbooks/`
* `sudo chef-solo -c solo.rb -j runlist.json`
* Access the Jenkins instance
