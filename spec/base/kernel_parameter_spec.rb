require 'spec_helper'

##全サーバ共通のkernel_parameter設定

describe 'Linux kernel parameters' do
  #カーネルバージョン
  context linux_kernel_parameter('kernel.osrelease') do
    its(:value) { should eq '2.6.32-642.1.1.el6.x86_64' }
  end

  #メモリの動的割り当て最大値
  context linux_kernel_parameter('vm.overcommit_ratio') do
    its(:value) { should eq 50 }
  end


  #大容量メモリの要求受付の可否 
  #0:明らかに無効な要求は失敗させるつもり 
  #1:カーネルはメモリオーバーコミット処理を行はない 
  #2:メモリのオーバーコミットのリスクを減らしたい場合は、この設定が最適
  context linux_kernel_parameter('vm.overcommit_memory') do
    its(:value) { should eq 0 }
  end

  #上記設定を2にした場合考慮が必要
  #メモリの動的割り当て最大値
  context linux_kernel_parameter('vm.overcommit_ratio') do
    its(:value) { should eq 50 }
  end

  #OOM発動時の処置
  #0:oom_killer 機能を呼び出し適当にプロセスを殺すことでシステムを維持（殺されたら困るプロセスはoom_scoreの値を-17に）
  #1:kernel panicを起こして再起動
  context linux_kernel_parameter('vm.panic_on_oom') do
    its(:value) { should eq 0 }
  end


  #SYN flood対策
  context linux_kernel_parameter('net.ipv4.tcp_syncookies') do 
    its(:value) { should eq 1 }
  end

  #システム全体の共有メモリ・ページの最大数
  context linux_kernel_parameter('kernel.shmall') do
    its(:value) { should be >= 4294967296 }
  end

  ###共有メモリの最大サイズ。搭載メモリサイズによってに変更変更するのでここではなくロールの下に置くべき
  context linux_kernel_parameter('kernel.shmmax') do
    its(:value) { should be <= 68719476736 }
  end

  ###TCPウインドウスケーリング有効化 通信サーバとそれ以外で分ける必要があるか検討
  context linux_kernel_parameter('net.ipv4.tcp_window_scaling') do
    its(:value) { should eq 1 }
  end

  ###受信用ウインドウサイズ最大値 通信サーバとそれ以外で分ける必要があるか要検討でもサーバ用途だから16777216とかに統一しても好いかも
  context linux_kernel_parameter('net.core.rmem_max') do
    its(:value) { should eq 124928 }
  end

  ###送信用ウインドウサイズ最大値 通信サーバとそれ以外で分ける必要があるか要検討でもサーバ用途だから16777216とかに統一しても好いかも
  context linux_kernel_parameter('net.core.wmem_max') do
    its(:value) { should eq 124928 }
  end

  ###送信バッファ サイズ 通信サーバとそれ以外で分ける必要があるか検討
  context linux_kernel_parameter('net.ipv4.tcp_wmem') do
    its(:value) { should match /4096\t16384\t4194304/ }
  end

  ###接続要求格納キュー長最大値 通信サーバとそれ以外で分ける必要があるか要件等でもサーバ用途だから4096とかに統一しても好いかも
  context linux_kernel_parameter('net.core.somaxconn') do
    its(:value) { should be 128 }
  end

  ###カーネルのキューイング可能なパケット最大値 通信サーバとそれ以外で分ける必要があるか要件等でもサーバ用途だから1000とかに統一しても好いかも
  context linux_kernel_parameter('net.core.netdev_max_backlog') do
    its(:value) { should be 1000 }
  end

  ###ソケット毎SYN Wait数上限 通信サーバとそれ以外で分ける必要があるか要件等でもサーバ用途だから4096とかに統一しても好いかも
  context linux_kernel_parameter('net.ipv4.tcp_max_syn_backlog') do
    its(:value) { should be 2048 }
  end

  ###RSTパケット受信時の即時クローズ有効化 
  #0:TIME_WAIT状態時にRSTを受信した場合、TIME_WAIT期間が終了するまで待つ
  #1:TIME_WAIT状態時にRSTを受信した場合、TIME_WAIT期間の終了を待たずに即ソケットをクローズ（RFC1337準拠）
  context linux_kernel_parameter('net.ipv4.tcp_rfc1337') do
    its(:value) { should be 0 }
  end


  ###システム全体のファイルディスクリプタの上限 もうすべてのサーバで1314786にしておいていいような気がする
  #1ファイル開くのにかかるコストは約1K つまり438262の場合438MB AEの4937178の場合約4.9G どっかのタイミングで以下を試してみたい
  #[root@postgresql1 ~]# cat /proc/sys/fs/file-nr
  #480     0       438262
  #OS起動後これまでの最大数  空きファイル管理データの数  fs.file-maxの数
  #/etc/security/limits.confでユーザ単位での指定をしている場合チェックしきれなさそう
  #tfxxx soft nofile 65536
  #tfxxx hard nofile 65536


  context linux_kernel_parameter('fs.file-max') do
    its(:value) { should be >= 438262 }
  end

end
 
