# インフラテスト：サンプルテストコード

これはインフラテストのためのサンプルコードです。

    .  
    |-- README.md  
    |-- Rakefile  
    |-- report  
    |   `-- serverspec  
    |       |-- results_postgresql1.vmtest.local.xml  
    |       `-- results_postgresql2.vmtest.local.xml  
    `-- spec  
        |-- apex  
        |   `-- apex_spec.rb  
        |-- base  
        |   |-- kernel_parameter_spec.rb  
        |   |-- logs_spec.rb  
        |   |-- packages_spec.rb  
        |   |-- security_spec.rb  
        |   `-- users_and_groups_spec.rb  
        |-- db  
        |   |-- kernel_parameter_spec.rb  
        |   `-- postgresql_spec.rb  
        |-- hulft  
        |   `-- hulft_spec.rb  
        |-- linkexpress  
        |   `-- linkexpress_spec.rb  
        |-- production  
        |   |-- production_hosts_spec.rb  
        |   `-- production_network_spec.rb  
        |-- spec_helper.rb  
        `-- staging  
            `-- gems_spec.rb  
  

