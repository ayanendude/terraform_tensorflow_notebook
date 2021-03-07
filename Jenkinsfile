
node {

    withEnv(
        [
        'AZURE_CLIENT_ID=358fcee4-2630-44c5-ba1c-7749e1bd0b3e',
        'AZURE_SUBSCRIPTION_ID=e4c8884e-3378-4478-917f-2d8ef1106b8f',
        'AZURE_TENANT_ID=69894ea5-714b-432f-9350-6f7d1ff0d39d',
        'PATH+EXTRA=/usr/local/bin',
        'ARM_CLIENT_ID=358fcee4-2630-44c5-ba1c-7749e1bd0b3e',
        'ARM_SUBSCRIPTION_ID=e4c8884e-3378-4478-917f-2d8ef1106b8f',
        'ARM_TENANT_ID=69894ea5-714b-432f-9350-6f7d1ff0d39d']
    ) {

        stage ('Checkout') {
            checkout scm
        }

        stage ('Terraform init'){
            sh 'printenv'
            sh 'echo $AZURE_CLIENT_ID'
            sh 'echo $AZURE_CLIENT_SECRET'
            withCredentials([string(credentialsId: 'aks1', variable: 'AZURE_CLIENT_SECRET')]){
                sh "/Users/ayanendude/bin/az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID"
            }
            sh '/Users/ayanendude/bin/az account set -s $AZURE_SUBSCRIPTION_ID'
            sh "/usr/local/bin/terraform init"
            sh "echo $PATH"
        }

        stage ('Terraform plan'){
            withCredentials([string(credentialsId: 'aks1', variable: 'AZURE_CLIENT_SECRET')]){
                // sh "/Users/ayanendude/bin/az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID"
                // sh "/Users/ayanendude/bin/az login --allow-no-subscriptions --tenant $AZURE_TENANT_ID --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET"
                sh "/Users/ayanendude/bin/az login --allow-no-subscriptions --tenant $AZURE_TENANT_ID"
                //sh '/Users/ayanendude/bin/az account set -s $AZURE_SUBSCRIPTION_ID'
                //sh "/Users/ayanendude/bin/az login --service-principal -u api://358fcee4-2630-44c5-ba1c-7749e1bd0b3e -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID"
                // sh 'export ARM_CLIENT_ID=358fcee4-2630-44c5-ba1c-7749e1bd0b3e'
                // sh 'export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET'
                // sh 'export ARM_SUBSCRIPTION_ID=e4c8884e-3378-4478-917f-2d8ef1106b8f'
                // sh 'export ARM_TENANT_ID=69894ea5-714b-432f-9350-6f7d1ff0d39d'
                sh "/usr/local/bin/terraform plan -out plat_out"
            }
        }

        stage ('Display plan out'){
            // withCredentials([string(credentialsId: 'aks1', variable: 'AZURE_CLIENT_SECRET')]){
            //     sh "/Users/ayanendude/bin/az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID"
            // }
            // sh '/Users/ayanendude/bin/az account set -s $AZURE_SUBSCRIPTION_ID'
            sh "/usr/local/bin/terraform show -json plat_out"
        }
    //}
        stage ('Approval Process') {
            timeout(time: 15, unit: "MINUTES") {
                input message: 'Do you want to approve Apply/Destroy action', ok: 'Yes'
            }
        }
    //}
//}
// node {

//     withEnv(
//     [
//     'AZURE_CLIENT_ID=358fcee4-2630-44c5-ba1c-7749e1bd0b3e',
//     'AZURE_SUBSCRIPTION_ID=e4c8884e-3378-4478-917f-2d8ef1106b8f',
//     'AZURE_TENANT_ID=69894ea5-714b-432f-9350-6f7d1ff0d39d',
//     'PATH+EXTRA=/usr/local/bin',
//     'ARM_CLIENT_ID=358fcee4-2630-44c5-ba1c-7749e1bd0b3e',
//     'ARM_SUBSCRIPTION_ID=e4c8884e-3378-4478-917f-2d8ef1106b8f',
//     'ARM_TENANT_ID=69894ea5-714b-432f-9350-6f7d1ff0d39d']
//     ) {
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

                withCredentials([string(credentialsId: 'aks1', variable: 'AZURE_CLIENT_SECRET')]){
                    sh "/Users/ayanendude/bin/az login --allow-no-subscriptions --tenant $AZURE_TENANT_ID"
                    if( "${USER_INPUT}" == "Apply"){
                        sh "/usr/local/bin/terraform apply -auto-approve"
                    } else {
                        sh "/usr/local/bin/terraform destroy -auto-approve"
                    }
                }
            }
        }
    }
}