# highstate to run when minions start
# os:Raspbian
highstate_raspbian_users:
  local.state.apply:
    - tgt: 'os:Raspbian'
    - tgt_type: grain
    - arg:
      - users
