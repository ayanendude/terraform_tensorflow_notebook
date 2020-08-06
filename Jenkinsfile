node {
    stage ('Checkout') {
        checkout scm
    }

    stage ('Terraform init'){
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