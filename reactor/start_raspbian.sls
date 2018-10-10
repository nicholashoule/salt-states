# os:Raspbian
highstate_raspbian_run_packages:
  local.state.apply:
    - tgt: 'os:Raspbian'
    - tgt_type: grain
    - arg:
      - packages

highstate_raspbian_run_users:
  local.state.apply:
    - tgt: 'os:Raspbian'
    - tgt_type: grain
    - arg:
      - users
