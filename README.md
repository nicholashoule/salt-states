# Saltstack: salt-states

Example SaltStack states configurations.

This repo is intended to be used in conjunction with my salt-pillar repo found here: https://github.com/nicholashoule/salt-pillar. You may use your own salt-pillar repo and/or reference local files in your pillar_roots settings.


## SaltStack - Master
*/etc/salt/master*

```
# Verify and set permissions on configuration directories at startup:
verify_env: True

# A regular expression (or a list of expressions) that will be matched
# against the file path before syncing the modules and states to the minions.
# This includes files affected by the file.recurse state.
# For example, if you manage your custom modules and states in subversion
# and don't want all the '.svn' folders and content synced to your minions,
# you could set this to '/\.svn($|/)'. By default nothing is ignored.
file_ignore_regex:
  - '/\.svn($|/)'
  - '/\.git($|/)'

# File Server Backend
#
# Salt supports a modular fileserver backend system, this system allows
# the salt master to link directly to third party systems to gather and
# manage the files available to minions. Multiple backends can be
# configured and will be searched for the requested file in the order in which
# they are defined here. The default setting only enables the standard backend
# "roots" which uses the "file_roots" option.
#fileserver_backend:
#  - roots
#
# To use multiple backends list them in the order they are searched:
fileserver_backend:
  - git
  - roots

# When using the git fileserver backend at least one git remote needs to be
# defined. The user running the salt master will need read access to the repo.
#
# The repos will be searched in order to find the file requested by a client
# and the first repo to have the file will return it.
# When using the git backend branches and tags are translated into salt
# environments.
# Note: file:// repos will be treated as a remote, so refs you want used must
# exist in that repo as *local* refs.
gitfs_remotes:
  - https://github.com/[namespace]/salt-states.git:
    - user: [user]
    - password: [password]

# The gitfs_ssl_verify option specifies whether to ignore ssl certificate
# errors when contacting the gitfs backend. You might want to set this to
# false if you're using a git backend that uses a self-signed certificate but
# keep in mind that setting this flag to anything other than the default of True
# is a security concern, you may want to try using the ssh transport.
gitfs_ssl_verify: True

#####         Pillar settings        #####
##########################################
# nicholashoule/salt-pillar
# https://github.com/nicholashoule/salt-pillar/edit/master/README.md

######        Reactor Settings        #####
###########################################
# Define a salt reactor. See https://docs.saltstack.com/en/latest/topics/reactor/
#reactor:
#  - 'salt/minion/*/start':             # Match tag "salt/minion/*/start"
reactor:
  - 'minion_start':
    - salt://reactor/start_raspbian_users.sls    # Things to do when a ubuntu minion starts
    - salt://reactor/start_raspbian_packages.sls # Things to do when a ubuntu minion starts
    - salt://reactor/start_ubuntu_users.sls      # Things to do when a Raspbian minion starts
    - salt://reactor/start_ubuntu_packages.sls   # Things to do when a Raspbian minion starts
    - salt://reactor/sync_grains.sls             # Sync custom grains

```

## SALT STATE FUNCTIONS

Salt State functions are what do the work in your Salt states, and are the most important thing to master when using SaltStack’s configuration management system.

Functions are available to install and configure applications, create users, distribute files, and about anything else you might need to do when setting up your systems.

Before we call any functions, let’s go over how Salt states are represented and the syntax for Salt state function calls.

Link: https://docs.saltstack.com/en/getstarted/config/functions.html
