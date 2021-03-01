node {

    environment {
        AZURE_CLIENT_SECRET = credentials('aks1')
        AZURE_CLIENT_ID="358fcee4-2630-44c5-ba1c-7749e1bd0b3e"
        AZURE_SUBSCRIPTION_ID="e4c8884e-3378-4478-917f-2d8ef1106b8f"
        AZURE_TENANT_ID="69894ea5-714b-432f-9350-6f7d1ff0d39d"
    }

    stage ('Checkout') {
        checkout scm
    }

    stage ('Terraform init'){
        sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
        sh 'az account set -s $AZURE_SUBSCRIPTION_ID'
        sh "/usr/local/bin/terraform init"
    }

    stage ('Terraform plan'){
        sh "/usr/local/bin/terraform plan -out plat_out"
    }

    stage ('Display plan out'){
        sh "/usr/local/bin/terraform show -json plat_out"
    }
}
stage ('Approval Process') {
    timeout(time: 15, unit: "MINUTES") {
        input message: 'Do you want to approve Apply/Destroy action', ok: 'Yes'
    }
}
node {
    stage ('Terraform apply or destroy') {
        script {
            // Define Variable
            def USER_INPUT = input(
                    message: 'Do you want to create(Apply) or remove(Destroy) resources? ',
                    parameters: [
                            [$class: 'ChoiceParameterDefinition',
                            choices: ['Apply','Destroy'].join('\n'),
                            name: 'input',
                            description: 'Menu - select box option']
                    ])

            echo "The answer is: ${USER_INPUT}"

            if( "${USER_INPUT}" == "Apply"){
                sh "/usr/local/bin/terraform apply -auto-approve"
            } else {
                sh "/usr/local/bin/terraform destroy -auto-approve"
            }
        }
    }
}