#!/bin/bash
# Function to run packer and terraform
function run_terraform(){
    packer build packer.json
    terraform init
    terraform plan
    terraform apply
}

function main (){
    run_terraform
}
main