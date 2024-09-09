#!/bin/bash

code_clone(){
        echo "Cloning file"
        git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements(){
        echo "Installing updates"
        sudo apt update && sudo apt install -y docker.io nginx docker-compose ||
                echo "Failed to install"
}

required_restarts(){
        echo "Restarting"
        sudo chown $USER /var/run/docker.sock
        sudo systemctl enable nginx
        sudo systemctl enable docker
        sudo systemctl restart docker
}

deploy(){
        docker build -t notes-app .
        #docker-compose up -d
        docker run -d -p 8000:8000 notes-app:latest
}

echo "DEPLOYMENT STARTED"
if !  code_clone; then
        echo "File already exists"
        cd django-notes-app
fi

if ! install_requirements; then
        echo "Installation failed"
        exit 1
fi

if ! required_restarts; then
        echo "System fault"
        exit 1
fi

if ! deploy; then
        # sendmail
        exit 1
fi
