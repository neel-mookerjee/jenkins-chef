## Few useful commands
rm -Rf /home/pivotalci/soft-arch-jenkins-chef/cookbooks
rm -r ~/.berkshelf/cookbooks
git pull
berks install && berks vendor cookbooks/
sudo chef-solo -c solo.rb -j runlist.json
