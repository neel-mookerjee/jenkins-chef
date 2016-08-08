artifact_jobs = [
 {
    job_name: 'cloud-tracing_deploy_artifact',
    git_url: ,
    artifact_deploy_path: 'cloud/$RELEASE_TAG',
    artifacts: [
    ],
    build_commands: [
      './gradlew clean assemble'
    ],
    project_name: 'cloud-tracing'
 }
]

artifact_jobs.each do |job|
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
