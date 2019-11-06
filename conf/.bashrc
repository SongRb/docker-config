alias ptpython="python -m ptpython"
alias hddfs="hdfs dfs"
alias mcp="mvn clean package"
alias zd="zip -d ./target/fraudect-0.1.2-SNAPSHOT.jar META-INF/*.RSA META-INF/*.DSA META-INF/*.SF"
alias n2v="spark-submit --class com.songrb.Main ./target/fraudect-0.1.2-SNAPSHOT.jar"
alias mzn="mcp && zd && n2v"

export Data=/host/mnt/sdb2/tangsongkai
