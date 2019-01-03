# terraform_extensive_kitchen

### Purpose of the repository 
- The repository creates EC2 Ubuntu and CentOS instances in AWS and test those instances with `kitchen` framework.

#### List of files in the repository

File name                            | File description 
------------------------------------ | --------------------------------------------------------------
`test/fixtures/wrapper/main.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
`test/fixtures/wrapper/variables.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
`test/fixtures/wrapper/outputs.tf` | test fixture Terraform configuration to invoke the Terraform module under test.
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


### Commands needed to test with `kitchen`.

Command execution |	Command outcome
------------------|--------------------------
`bundle exec kitchen list` | to list `kitchen` instances.
`bundle exec kitchen converge` | to create `kitchen` environment.
`bundle exec kitchen verify` | command to execute `kitchen` test.
`bundle exec kitchen destroy` | to destroy `kitchen` environment.
`bundle exec kitchen test` | to automatically build, test and destroy `kitchen` environment.

- If the command/s complete successfully the output will display the following:


### TO DO: 
- Check if everything works as expected. 
