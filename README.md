![GitHub](https://img.shields.io/badge/GitHub-Repo-181717?logo=github&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-v1.12.2-623CE4?logo=terraform&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20LTS-E95420?logo=ubuntu&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-v2.452+-D24939?logo=jenkins&logoColor=white)
![HCL](https://img.shields.io/badge/Language-HCL-844FBA?logo=hashicorp&logoColor=white)
![Language](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)

# Terraform Pipeline in Jenkins
> [!IMPORTANT]
> *Before anything else, there are pre-requisite tools need to set-up before writing up a Jenkinsfile pipeline*

- Jenkins Server (Either creating server via AWS Account or WSL2) 
- Github PAT
- AWS Access and Secret Key

> [!CAUTION]
> *Applying redentials such as Github PAT, AWS Access and Secret Key must not be visibile here in this repository. These mentioned credentials must be shared internally.*

# Pre-requisites

### Jenkins server set-up
1. Create server via **EC2 instance**
2. SSH the server and follow the installation steps for **[Jenkins](https://www.jenkins.io/doc/book/installing/linux/)**. This can be done via **VSCode Terminal**, **MobaXterm**, or **WSL2**. 
3. After setting-up Jenkins application, kindly select **Install Suggested plugins** and wait for it to finish.
4. Setup credentials for login of Jenkins account

> [!NOTE]
> *Jenkins is JAVA-based application which required to install JAVA before installing [here](https://www.jenkins.io/doc/book/installing/linux/#installation-of-java).*

### Generating AWS Secret and Access Keys
1. Go to **Security Credentials** under your AWS Account
2. Select Access Key button and it will generate Access and Secret Key.

> [!CAUTION]
> *The secret key will only appeared once it was generated. Keep in mind that it must be copy moving on to next step.*

### Generating Github PAT
1. Go to Settings and select **Developer Settings** 
2. Select Access Key button and it will generate Access and Secret Key.
3. Select Personal access token, under the dropdown, choose **Tokens (classic)**.
4. On the upper right corner, select **Generate new token (classic)**.
5. Fill-up the note and tick all checkboxes and **Generate token**. 

> [!CAUTION]
> *The secret key will only appeared once it was generated. Keep in mind that it must be copy moving on to next step.*


### Datadog Agent set-up (Web/App server)
1. Go to Agent tab, under Host-based, select your OS you preferred.
2. In setting-up for Ubuntu server, either "Generate" (applicable only if you don't have one) or "Select" API key (applicable for existing API key).
3. Run this command below on our Web/App server:
```
DD_API_KEY=<DATADOG_API_KEY> \
DD_SITE="datadoghq.com" \ 
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
```
4. Run these following command below to verify that Datadog status was running/active.
```
sudo systemctl restart datadog-agent
sudo systemctl status datadog-agent
```
5. For configurations, kindly go to datadog.yaml file. You may use locate or find command to identify where it was located. Save and restart the service once the configurations are all applied.