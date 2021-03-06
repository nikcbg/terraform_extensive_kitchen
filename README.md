# terraform_extensive_kitchen

### Purpose of the repository 
- The repository creates EC2 Ubuntu and CentOS instances in AWS and test those instances with `kitchen` framework.

#### List of files in the repository

File name                            | File description 
------------------------------------ | --------------------------------------------------------------
`test/fixtures/wrapper/main.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
`test/fixtures/wrapper/variables.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
`test/fixtures/wrapper/outputs.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
`test/generate_ssh_key.sh` | `bash` script for genreating `SSH` key to authenticate with the AWS EC2 instances.
`.kitchen.yml` | configuration file for `kitchen` test framework.
`Gemfile` | used for ruby dependencies.
`main.tf` | Terraform module configuration file for building EC2 instance.
`variables.tf` | Terraform module configuration file with environmental variables.
`output.tf` | Terraform module configuration file with output parameters.

### How to use this repository. 
- Install `terraform` by following this [instructions](https://www.terraform.io/intro/getting-started/install.html).
- To be able to crete the EC2 instances, you need to have AWS accoount with:
 - [AWS key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
 - [AWS access and secret keys](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- Clone the repository to your local computer: `git clone git@github.com:nikcbg/terraform_extensive_kitchen`.
- Go to the cloned repo on your computer: `cd terraform_extensive_kitchen`.

### SECURITY WARNING: THE FILE MENTIONED BELOW CONTAINS SENSITIVE INFORMATION, MAKE SURE THE FILE IS NOT EXPOSED TO THE INTERNET OR ANY OTHER PUBLIC PLACES.
- You need to create `filename.tfvars` file that has AWS key pair, access and secret keys (file must have `.tfvars` extension).  
- Terraform will use credentials in the file to create the EC2 instances.
- the file format should be as follow:

```
AWS_ACCESS_KEY_ID = "AWS access key here"

AWS_SECRET_ACCESS_KEY = "AWS secret key here"

key_pair_public_key = "path/to/your/key/file.pem"
```

### Setting up `ruby` environment for `kitchen` testing framework:

Command execution |	Command outcome
------------------|--------------------------
`sudo apt update` | to update the packages on your machine.
`sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev` | to install ruby dependencies.
`git clone https://github.com/rbenv/rbenv.git ~/.rbenv` | to clone rbenv repo.
`echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc` | to change your `~/.bashrc` file.
`'eval "$(rbenv init -)"' >> ~/.bashrc` | so rbenv loads automatically.
`source ~/.bashrc` | to reload bash profile.
`rbenv` | command to verify that `rbenv` is set up properly.
`rbenv install 2.3.1`	| to install ruby 2.3.1 version.
`rbenv local 2.3.1`	| to set the default version of ruby to your local directory.
`rbenv -v`	| to make sure ruby is installed and you have the correct version.
`gem install bundler`	| to install gem which is package manager for ruby.
`bundle install` |  install the dependencies specified in the Gemfile.
  
### Performing test with `kitchen` framework.
- you need to run the tests separate for each instance.
- execute the scripts below: 

```
function drop_aws_sts_session {
  unset AWS_ACCESS_KEY_ID
  unset AWS_DEFAULT_REGION
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}
```
```
function export_aws_sts_session {
  drop_aws_sts_session
  session="$(aws sts get-session-token --output=json)"
  AWS_ACCESS_KEY_ID="$(echo $session | jq -r .Credentials.AccessKeyId)"
  AWS_DEFAULT_REGION="$1"
  AWS_SECRET_ACCESS_KEY="$(echo $session | jq -r .Credentials.SecretAccessKey)"
  AWS_SESSION_TOKEN="$(echo $session | jq -r .Credentials.SessionToken)"
  export AWS_ACCESS_KEY_ID
  export AWS_DEFAULT_REGION
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN
}
```

### Commands for running CentOS test

Command execution |	Command outcome
------------------|--------------------------
`export_aws_sts_session "us-east-1"` | initialize conection to AWS us-east-1 region.
`bundle exec kitchen destroy centos` | destroy any existing Terraform state in us-east-1
`bundle exec kitchen create centos` | initialize the Terraform working directory and select a new Terraform workspace.
`bundle exec kitchen converge centos` | apply the Terraform root module to the Terraform state.
`bundle exec kitchen verify centos` | test the Terraform state using the InSpec controls.
`bundle exec kitchen destroy centos` | destroy the Terraform state using the Terraform fixture configuration.

- If the commands complete successfully the output will display the following:
```
  ✔  operating_system: centos
     ✔  centos should eq "centos"
  ✔  reachable_other_host: Host 11.222.333.44

     ✔  Host 11.222.333.44
      should be reachable


Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 2 successful, 0 failures, 0 skipped

Profile: Extensive Kitchen-Terraform (extensive_suite)
Version: 0.1.0

  ✔  operating_system: centos
     ✔  centos should eq "centos"
  ✔  reachable_other_host: Host 11.222.333.44
     ✔  Host 11.222.333.44
      should be reachable

Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 2 successful, 0 failures, 0 skipped
       Finished verifying <extensive-suite-centos> (0m23.85s).
-----> Kitchen is finished. (0m25.38s)
```

### Commands for running Ubuntu test
Command execution |	Command outcome
------------------|--------------------------
`export_aws_sts_session "us-west-2"` | initialize conection to AWS us-west-2 region.
`bundle exec kitchen test ubuntu` | automatically build, test and destroy kitchen environment for Ubuntu instance.

-  If the command completes successfully the output will display the following:

```
 Destroy complete! Resources: 11 destroyed.
$$$$$$ Running command `terraform workspace select default` in directory /home/name/test_repos/terraform_extensive_kitchen/test/fixtures/wrapper
       Switched to workspace "default".
$$$$$$ Running command `terraform workspace delete kitchen-terraform-extensive-suite-ubuntu` in directory /home/name/test_repos/terraform_extensive_kitchen/test/fixtures/wrapper
       Deleted workspace "kitchen-terraform-extensive-suite-ubuntu"!
       Finished destroying <extensive-suite-ubuntu> (1m24.83s).
       Finished testing <extensive-suite-ubuntu> (3m20.36s).
-----> Kitchen is finished. (3m21.72s)
```

### TO DO: 
- Check if everything works as expected. 
