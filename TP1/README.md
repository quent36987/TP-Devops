# Gitlab en local avec runner

## Installation

```shell
# Run Gitlab (take few minutes)
docker compose up -d

# Get the initial root password
sudo docker exec -it gitlab-ce grep 'Passwo
rd:' /etc/gitlab/initial_root_password
```

## Configuration
change username : 
http://gitlab.exemple/-/profile/account

change password :
http://gitlab.exemple/-/profile/password/edit

create a new token :
http://gitlab.exemple/-/profile/personal_access_tokens
get runner rights and add the token to the .env file
GITLAB_API_TOKEN=xxxxxxxxxxxxxxxxxxxx

## Runner

./create-runner.sh 1 => create a runner gitlab-runner-1




