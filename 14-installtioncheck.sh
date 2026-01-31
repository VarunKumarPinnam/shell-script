# #!/bin/bash

# USERID=$(id -u)

# if [ "$USERID" -ne 0 ]; then 
#     echo "Only root users can execute this script"
#     exit 1
# fi

# validation(){
#     if [ $1 -ne 0 ]; then 
#         echo "$2 is failed"
#         exit 1
#     else 
#         echo "$2 is completed"
#     fi
# }

# checksoft(){
#     if dnf list installed $1 &> /dev/null; then 
#         echo "$1 already installed"
#         exit 1
#     else
#         echo "Installing $1"
#         dnf install $1 -y
#     fi
# }

# checksoft nginx
# validation $? "nginx installation"

# checksoft mysql
# validation $? "mysql installation"

# checksoft nodejs
# validation $? "nodejs installation"


#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then
    echo "Only root users can execute this script"
    exit 1
fi

validation() {
    if [ "$1" -ne 0 ]; then
        echo "$2 FAILED"
        exit 1
    else
        echo "$2 COMPLETED"
    fi
}

install_if_missing() {

    if dnf list installed "$1" &>/dev/null; then
        echo "$1 already installed"
        return 0
    else
        echo "Installing $1"
        dnf install "$1" -y
        return $?
       echo  "Done"
    fi
}

install_if_missing ngginx
validation $? "nginx installation"

install_if_missing mysql
validation $? "mysql installation"

install_if_missing nodejs
validation $? "nodejs installation"
