# インフラテスト：サンプルテストコード

これはインフラテストのためのサンプルコードです。
specフォルダの下に環境だったり各サーバのロールだったりのディレクトリを作成しその中に各種テストコードを書いていきます。  
そしてそれらをRakefileファイルに  
```r
hosts = [
  {
    :name  => 'postgresql1.vmtest.local',
    :roles => %w( base production db ),
  },
}
```
と書くことでサーバpostgresql1.vmtest.localは、&color(「base」「production」「db」)ディレクトリ下のテストコードを実行します  
 

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
  

