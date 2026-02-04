# INSTALAÇÃO COMPLETA - CTF ROOTTHEBOX

## PRÉ-REQUISITOS
- Conta AWS com permissões EC2
- AWS CLI configurado
- PuTTYgen (Windows) ou ssh-keygen (Linux/Mac)

## PASSO 1: CONFIGURAR AWS CLI
```bash
aws configure
# AWS Access Key ID: [sua_key]
# AWS Secret Access Key: [sua_secret]
# Default region: us-east-1
```

## PASSO 2: CRIAR CHAVE SSH
```bash
# Linux/Mac:
ssh-keygen -t rsa -b 4096 -f ctf-private-key -N "" -C "CTF Access Key"
puttygen ctf-private-key -o ctf-private-key.ppk

# Windows:
# Use PuTTYgen para gerar chave RSA 4096 bits
# Salve como ctf-private-key.ppk
```

## PASSO 3: IMPORTAR CHAVE PARA AWS
```bash
aws ec2 import-key-pair --key-name ctf-access-key --public-key-material fileb://ctf-private-key.pub
```

## PASSO 4: CONFIGURAR SECURITY GROUP
```bash
# Criar Security Group
aws ec2 create-security-group --group-name ctf-sg --description "CTF Security Group"

# Adicionar regras
aws ec2 authorize-security-group-ingress --group-name ctf-sg --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ctf-sg --protocol tcp --port 2022 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ctf-sg --protocol tcp --port 8888 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ctf-sg --protocol tcp --port 80 --cidr 0.0.0.0/0
```

## PASSO 5: CRIAR VMs
```bash
# Buscar AMI Debian
AMI_ID=$(aws ec2 describe-images --owners 136693071363 --filters "Name=name,Values=debian-12-*" --query 'Images[0].ImageId' --output text)

# Criar 5 instâncias
aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 5 \
  --instance-type t3.micro \
  --key-name ctf-access-key \
  --security-groups ctf-sg \
  --associate-public-ip-address \
  --user-data file://AWS-original.sh
```

## PASSO 6: CONFIGURAR SSH NAS VMs
Após ~6 minutos, configure senha SSH:
```bash
# Para cada IP das VMs:
ssh -i ctf-private-key.pem admin@[IP_VM] "echo 'root:P@ssw0rd' | sudo chpasswd && sudo passwd -u root"
```

## PASSO 7: DISTRIBUIR ACESSO
- **Chave:** `ctf-private-key.ppk`
- **Guia:** `GUIA_CTF.md`
- **IPs:** Obter com `aws ec2 describe-instances`

## ARQUIVOS NECESSÁRIOS
- `AWS-original.sh` - Script de instalação
- `ctf-private-key.ppk` - Chave SSH (gerar)
- `GUIA_CTF.md` - Instruções para jogadores