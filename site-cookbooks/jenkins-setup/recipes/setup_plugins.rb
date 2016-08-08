plugins = [
  {name: 'promoted-builds', version: '2.21'}, # dependency of git
  {name: 'scm-api', version: '0.2'}, # dependency of git
  {name: 'token-macro', version: '1.10'}, # dependency of git
  {name: 'parameterized-trigger', version: '2.4'}, # dependency of git
  {name: 'git-client', version: '1.19.0'}, # dependency of git
  {name: 'git', version: '2.4.4'},
  {name: 'gradle', version: '1.24'},
  {name: 'greenballs', version: '1.14'},
  {name: 'envinject', version: '1.92.1'},
  {name: 'build-monitor-plugin', version: '1.6+build.159'},
  {name: 'ansicolor', version: '0.4.1'},
  {name: 'artifactory', version: '2.4.7'},
  {name: 'timestamper', version: '1.7.3'},
  {name: 'email-ext', version: '2.41.3'},
  {name: 'Parameterized-Remote-Trigger', version: '2.2.2'},
  {name: 'credentials-binding', version: '1.8'}
]

directory '/var/lib/jenkins/plugins' do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create
end

plugins.each do |plugin|
  remote_file "Jenkins plugin #{plugin[:name]}" do
    owner 'jenkins'
    group 'jenkins'
    path "/var/lib/jenkins/plugins/#{plugin[:name]}.hpi"
  end
end
