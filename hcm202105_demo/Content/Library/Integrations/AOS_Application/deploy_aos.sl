namespace: Integrations.AOS_Application
flow:
  name: deploy_aos
  inputs:
    - target_host: demo.hcmx.local
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 140
        'y': 248.734375
      install_java:
        x: 309
        'y': 252.734375
      install_tomcat:
        x: 465
        'y': 277.734375
      install_aos_application:
        x: 607
        'y': 267.734375
        navigate:
          c5a82346-8dc7-49a8-a644-51816e5354d4:
            targetId: a9fa71a8-c96a-c6bd-7879-57866ad69427
            port: SUCCESS
    results:
      SUCCESS:
        a9fa71a8-c96a-c6bd-7879-57866ad69427:
          x: 763
          'y': 256
