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
と書くことでサーバpostgresql1.vmtest.localは、「base」「production」「db」ディレクトリ下のテストコードが実行対象になります 
使い方は 
実施可能なテストの一覧表示 
```b
[root@ansible serverspec]# rake -T
rake serverspec              # Run serverspec to all hosts
rake serverspec:ansible      # Run serverspec to ansible.vmtest.local
rake serverspec:postgresql1  # Run serverspec to postgresql1.vmtest.local
rake serverspec:postgresql2  # Run serverspec to postgresql2.vmtest.local
```
サーバpostgresql1のテスト実行　（「CI_FLAG=true」を付けることでテスト結果をJUnit形式に変換）  
```b
[root@ansible serverspec]# rake serverspec:postgresql1 CI_FLAG=true 
```

    .  
    |-- README.md  
    |-- Rakefile  
    |-- report  
    |   `-- serverspec  
    |       |-- results_postgresql1.vmtest.local.xml  
    |       `-- results_postgresql2.vmtest.local.xml  
    `-- spec  
        |-- apex （apex関連のテスト） 
        |   `-- apex_spec.rb  
        |-- base  （全サーバ共通のテスト）  
        |   |-- kernel_parameter_spec.rb  
        |   |-- logs_spec.rb  
        |   |-- packages_spec.rb  
        |   |-- security_spec.rb  
        |   `-- users_and_groups_spec.rb  
        |-- db  （DB関連のテスト） 
        |   |-- kernel_parameter_spec.rb  
        |   `-- postgresql_spec.rb  
        |-- hulft  （HULFT関連のテスト）  
        |   `-- hulft_spec.rb  
        |-- linkexpress　　（Linkexpress関連のテスト）  
        |   `-- linkexpress_spec.rb  
        |-- production  （プロダクション環境独自のテスト）  
        |   |-- production_hosts_spec.rb  
        |   `-- production_network_spec.rb  
        |-- spec_helper.rb  
        `-- staging  （ステージング環境独自のテスト）  
            `-- gems_spec.rb  
  
---
#テスト内容はともかく
