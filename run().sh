#!/bin/sh

if [ $# != 3 ]; then #如果参数不是3个，那么返回错误以及用法提示
  echo "Parameter Error."
  echo "Useage:./run.sh </input/file/path> </output/path> <data size>"
  echo ""
else #参数是3个时
  hadoop dfs -rmr /12330382/estimateTmp #清空本目录与目录下的文件【清楚之前的中间文件】，下同
  hadoop dfs -rmr /12330382/materializeTmp 
  hadoop dfs -rmr /12330382/partitions 

  hadoop jar  Estimate.jar org.myorg.Estimate $1 /12330382/estimateTmp $3 #第一步 输入是第一个参数，输出在estimateTmp文件夹中 数据量为$3
  hadoop jar  Materialize.jar org.myorg.Materialize $1 /12330382/materializeTmp #第二步 输入是$1，输出是materializeTmp
  hadoop jar  Postprocess.jar org.myorg.Postprocess /12330382/materializeTmp $2 #第三步 输入是第二步的输出，输出是$2
  # org.myorg.Estimate等是定义的入口类名
  hadoop dfs -rmr /12330382/ #清空12330382目录
  
fi
