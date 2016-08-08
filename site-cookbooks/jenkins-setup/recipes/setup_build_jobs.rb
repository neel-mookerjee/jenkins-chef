build_jobs = [
  {
    job_name: 'cloud-tracing_build',
    git_url: 'https://gitlab.global.com/software-architecture/cloud-tracing.git',
    git_branch: '*/master',
    project_name: 'cloud-tracing'
  }
]

directory "/var/lib/jenkins/jobs" do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create
end

build_jobs.each do |job|
  directory "/var/lib/jenkins/jobs/#{job[:job_name]}" do
    owner 'jenkins'
    group 'jenkins'
    mode '0755'
    action :create
  end
  template "/var/lib/jenkins/jobs/#{job[:job_name]}/config.xml" do
    source "#{job[:job_name]}.xml.erb"
    variables job
    user 'jenkins'
    group 'jenkins'
    mode '0755'
  end
end