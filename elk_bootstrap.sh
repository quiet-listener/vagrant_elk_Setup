#!/bin/bash
# set the ELK package versions
#i have installed elk offline because of slow internet connection.
#can be done through apt-get install
function elk_install(){
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    if [ ! -f "/etc/apt/sources.list.d/elastic-6.x.list" ];then
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    fi
    sudo apt-get update && sudo apt-get install -y default-jdk
    sudo apt-get -y install elasticsearch
    #sudo dpkg -i /vagrant/elk_bundle/elasticsearch-6.5.3.deb
    sudo apt-get install -y logstash
}

function elasticsearch_run(){
    sudo cp /vagrant/elk_files/hosts /etc/hosts
    sudo cp /vagrant/elk_files/elasticsearch_node"$node".yml /etc/elasticsearch/elasticsearch.yml
    sudo /bin/systemctl daemon-reload
    sudo /bin/systemctl enable elasticsearch.service
    sudo systemctl start elasticsearch.service
}

function kibana_run(){
    sudo apt-get install  -y kibana
    #sudo dpkg -i /vagrant/elk_bundle/kibana-6.5.3-amd64.deb
    sudo cp /vagrant/elk_files/kibana.yml /etc/kibana/kibana.yml
    sudo /bin/systemctl daemon-reload
    sudo /bin/systemctl enable kibana.service
    sudo systemctl start elasticsearch.service
    sudo systemctl start kibana.service
}

function logstash_syslog_copy(){
    # change the rsyslog file to send all logs to 514 port
    sudo cp /vagrant/elk_files/50-default.conf /etc/rsyslog.d/50-default.conf
    #copy config file to logstash conf.d
    sudo cp /vagrant/elk_files/logstash_syslog.conf /etc/logstash/conf.d/logstash_syslog.conf
    sudo service syslog restart
    sudo systemctl restart logstash
}

echo "elk_install"
elk_install
if [ "$HOSTNAME" == "elk-node2" ]; then
    echo "kibana_install"
    node=2
    elasticsearch_run
    kibana_run
else
    echo "elasticsearch node1"
    node=1
    elasticsearch_run
fi
logstash_syslog_copy
