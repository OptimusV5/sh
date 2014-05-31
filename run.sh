#!/bin/sh

if [ $# != 3 ]; then
  echo "Parameter Error."
  echo "Useage:./run.sh </input/file/path> </output/path> <data size>"
  echo ""
else
  hadoop dfs -rmr /12330382/estimateTmp
  hadoop dfs -rmr /12330382/materializeTmp 
  hadoop dfs -rmr /12330382/partitions

  hadoop jar  Estimate.jar org.myorg.Estimate $1 /12330382/estimateTmp $3
  hadoop jar  Materialize.jar org.myorg.Materialize $1 /12330382/materializeTmp
  hadoop jar  Postprocess.jar org.myorg.Postprocess /12330382/materializeTmp $2
  hadoop dfs -rmr /12330382/
  
fi
