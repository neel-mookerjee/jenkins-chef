package 'cf-cli'
package 'java-1.8.0-openjdk'
include_recipe 'git::default'

yum_package 'jenkins' do
  version '1.631-1.1'
  action :install
  allow_downgrade true
end

# Create jenkins users
users 'jenkins' do
  users [{
           'gid' => 'jenkins',
           'home' => '/var/lib/jenkins',
           'username' => 'jenkins',
           'ssh_keys' => [],
           'password' => '$1$3VAJvjpe$Hw/foLjC3Y44wZJY6PvER0'
         }]
  action :create_users
end

# Install java things
java 'java 8_u31' do
  java_home '/var/lib/jenkins/jdk1.8.0_31'
  java_source 'https://artifactory.global.com/artifactory/jdk/linux/jdk-8u31-linux-x64.tar.gz'
  user 'jenkins'
  group 'jenkins'
  action [:install]
end

# Install more jenkins things
cookbook_file '/var/lib/jenkins/credentials.xml' do
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  source 'credentials.xml'
end

# Setup build monitors
cookbook_file '/var/lib/jenkins/config.xml' do
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  source 'config.xml'
end

# Setup artifactory
cookbook_file '/var/lib/jenkins/org.jfrog.hudson.ArtifactoryBuilder.xml' do
  owner 'jenkins'
  group 'jenkins'
  mode '0644'
  source 'org.jfrog.hudson.ArtifactoryBuilder.xml'
end

service 'jenkins' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable]
end

bash 'restart jenkins' do
  user 'root'
  code 'service jenkins restart'
end

ruby_block 'change jenkins timezone to Denver time' do
  block do
    file = Chef::Util::FileEdit.new('/etc/sysconfig/jenkins')
    file.search_file_replace_line('JENKINS_JAVA_OPTIONS=', 'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Denver"')
    file.write_file
  end
end