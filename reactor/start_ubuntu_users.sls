# highstate to run when minions start
# os:Ubuntu      
highstate_ubuntu_users:
  local.state.apply:
    - tgt: 'os:Ubuntu'
    - tgt_type: grain
    - arg:
      - users
