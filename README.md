# Criação de Serviços na AWS com Terraform

[<img src="https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" />](https://www.linkedin.com/in/matheusnatividade/)

## Descrição

O projeto **Criação de Serviços na AWS com Terraform** é uma implementação de infraestrutura como código utilizando o Terraform para criar serviços essenciais na Amazon Web Services (AWS). Ele automatiza a criação de uma VPC (Virtual Private Cloud), uma instância EC2 com um servidor web em execução em containers Docker e um grupo de segurança para gerenciar o acesso. Esse projeto é uma excelente maneira de aprender e praticar a utilização do Terraform para criar ambientes na AWS.

## Como Funciona

O projeto utiliza a linguagem declarativa do Terraform para definir a configuração da infraestrutura desejada em arquivos de configuração, como o `main.tf` fornecido neste repositório. Os recursos AWS, como VPCs, subnets, instâncias EC2 e grupos de segurança, são definidos nesses arquivos, permitindo a criação e gerenciamento da infraestrutura com facilidade.

## Como Usar

Antes de executar o Terraform, você precisará configurar suas credenciais da AWS no AWS CLI. Siga os passos abaixo:

1. Instale o AWS CLI seguindo as instruções do site oficial: [AWS CLI - Instalação](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

2. Configure suas credenciais usando o comando `aws configure`. Insira sua Access Key, Secret Key, região padrão e formato de saída (json, por exemplo).

   ```bash
   aws configure
   ```

Agora você está pronto para executar o Terraform:

1. Certifique-se de que o Terraform esteja instalado em seu sistema. Você pode verificar executando `terraform version`.

2. Navegue até o diretório onde o arquivo `main.tf` está localizado.

3. Inicialize o Terraform executando `terraform init`.

4. Visualize as alterações que o Terraform fará executando `terraform plan`. Verifique se tudo está correto antes de aplicar as mudanças.

5. Aplique as alterações criando a infraestrutura com o comando `terraform apply`. Confirme a ação digitando "yes" quando solicitado.

Após a execução do `terraform apply`, a infraestrutura será criada na AWS e você verá informações sobre os recursos criados.

## Configuração da Instância EC2

A instância EC2 criada por este projeto utiliza a AMI do Amazon Linux 2, um sistema operacional leve e otimizado para a AWS. O servidor web é configurado automaticamente usando o Docker e executa o Apache HTTP Server na porta 80.

Se você deseja personalizar a configuração da instância, como o tipo, o sistema operacional ou os pacotes instalados, você pode alterar o arquivo `main.tf`. As opções para configurar a instância EC2 são amplas e podem ser encontradas na documentação da AWS.

## Atenção

Lembre-se de que a execução do Terraform criará recursos na AWS, o que pode incorrer em cobranças em sua conta da AWS. Certifique-se de revisar e entender os recursos criados antes de executar o Terraform.

## Contribuição

Contribuições são bem-vindas! Se você encontrar algum problema ou quiser sugerir melhorias, sinta-se à vontade para abrir uma issue ou criar um pull request.