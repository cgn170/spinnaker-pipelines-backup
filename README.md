# spinnaker-pipelines-backup

Scripts to make a backup of applications and pipelines in Spinnaker, must have already configured [spin](https://github.com/spinnaker/spin) and [jq](https://stedolan.github.io/jq/)

```
git clone https://github.com/cgn170/spinnaker-pipelines-backup.git
cd spinnaker-pipelines-backup
chmod +x *.sh
# to pull all applications and pipelines available in spinnaker execute:
./pull_applications_conf.sh
./pull_pipelines_conf.sh
# folders with the configuration, applications and pipelines
ls
# to push all changes made locally to spinnaker run:
./push_applications_conf.sh
./push_pipelines_conf.sh

```