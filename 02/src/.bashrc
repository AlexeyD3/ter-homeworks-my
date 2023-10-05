# .bashrc
#############################################
# не относящееся к заданию содержимое удалил
#############################################
# Get secrets for Yandex Cloud
export TF_VAR_yc_token=$(yc iam create-token)
export TF_VAR_yc_cloud_id=$(yc resource-manager cloud get devops-alexgoodesignpro | awk 'NR==1 { print substr ($ 0, 5)}')
export TF_VAR_yc_folder_id=$(yc resource-manager folder get default | awk 'NR==1 { print substr ($ 0, 5)}')
