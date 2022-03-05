## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](./Images/Unit_13.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Yml files may be used to install only certain pieces of it, such as Filebeat.

YML files referenced here:

[DVWA installation](https://github.com/alishababbar13/CSBootCampt/blob/ffd5649f8ce560b493debba4d1ef21c684fec786/Ansible/DVWA-Installation.yml)

[ELK installation](https://github.com/alishababbar13/CSBootCampt/blob/ffd5649f8ce560b493debba4d1ef21c684fec786/Ansible/ELK-Installation.yml)

[Filebeat Playbook](https://github.com/alishababbar13/CSBootCampt/blob/f410143f2f4ac7a3a8561f0d6a5c9b8ba9e4b185/Ansible/roles/filebeat-playbook.yml)

[Metric Playbook](https://github.com/alishababbar13/CSBootCampt/blob/ffd5649f8ce560b493debba4d1ef21c684fec786/Ansible/roles/metricbeat-playbook.yml)


This document contains the following details:
- Description of the Topologu\y
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load Balancers act as a reverse proxy and distributes network or application traffic across a number of servers. Load balancers are used to increase capacity (concurrent users) and reliability of applications. They improve the overall performance of applications by decreasing the burden on servers associated with managing and maintaining application and network sessions, as well as by performing application-specific tasks.
- A jump box is a secure computer that all admins first connect to before launching any administrative task or use as an origination point to connect to other servers or untrusted environments.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the **files** and system **metrics**.
- Filebeat watches for the changes in the files in the locations that we specify or the log files and then collects and send the data to logstash/elasticsearch.
- Metricbeat collects the metric data from the services and the operating system and sends it to logstash/elasticsearch

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway with ansible container |40.121.104.252| Ubuntu 18.04 Server LTS |
| Web-1    | Hosts DVWA Container Contains Filebeat and Metricbeat| 10.1.0.5 |  Ubuntu 18.04 Server LTS |
| Web-2    | Hosts DVWA Container Contains Filebeat and Metricbeat (backup) | 10.1.0.6 | Ubuntu 18.04 Server LTS |
| ELK-Sever | Hosts Elk stack container| 52.180.67.235  private ip 10.2.0.4 |  Ubuntu 18.04 Server LTS |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the **Jumpbox** machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- **99.234.0.0/16**

Machines within the network can only be accessed by **Jumpbox**.
- Jumpbox with the IP address 40.121.104.252 with the Ansible container can access the Elk server

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes              | 99.234.0.0/16    |
| Web-1   | No                    |  10.1.0.4 (Jumpbox Private IP)  |
| Web-2   |   No                  |  10.1.0.4         |
| ELK-Server   |   Yes      |   99.234.0.0/16    |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- This makes it easy for the purpose of configuring multiple machines in one go, and every VM does not need to be setup/configured manually.

The playbook implements the following tasks:
- Install docker.io
- Install PIP
- Install docker python module
- Download and Install a Docker elk container
- Run command to increase the memory

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](./Images/21E736C8-64BB-4B5A-801A-2B85F32C173D.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.1.0.5
- Web-2 10.1.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat watches for the changes in the files in the locations that we specify or the log files and then collects and send the data to logstash/elasticsearch for example the modifications in a file.
- Metricbeat collects the metric data from the services and the operating system and sends it to logstash/elasticsearch such as Apache service

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-playbook.yml and metricbeat-playbook.yml files to /etc/ansible/roles.
- Update the /etc/ansible/hosts file to include the ip addresses of the VMs below webservers
- Run the playbook, and navigate to http://52.180.67.235:5601 to check that the installation worked as expected.

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
- After having edited the hosts file to add the Web VM private IPs under webservers, run the following command:
- ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
- ansible-playbook /etc/ansible/roles/metricbeat-playbook.yml

For Filebeat:
- curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb
- sudo dpkg -i filebeat-7.6.1-amd64.deb
- sudo filebeat modules enable system
- sudo filebeat setup
- sudo service filebeat start
![](https://github.com/alishababbar13/CSBootCampt/blob/2507f2569f3eabdfc8caf6f8bb8df28b0267f65b/Images/Kibana-filebeat.png)

For Metricbeat:
- curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb
- sudo dpkg -i metricbeat-7.6.1-amd64.deb
- sudo metricbeat modules enable docker
- sudo metricbeat setup
- sudo service metricbeat start
![](https://github.com/alishababbar13/CSBootCampt/blob/2507f2569f3eabdfc8caf6f8bb8df28b0267f65b/Images/kibana-metricbeat.png)
