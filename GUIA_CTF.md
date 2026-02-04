# GUIA COMPLETO - CTF ROOTTHEBOX

## PASSO 1: BAIXAR CHAVE SSH
Baixe o arquivo: `ctf-private-key.ppk` (já está nesta pasta)

## PASSO 2: IPs DAS VMs
- VM 1: 54.234.131.82
- VM 2: 3.80.116.48
- VM 3: 54.196.169.46
- VM 4: 3.87.123.221
- VM 5: 100.53.132.229

## PASSO 3: ACESSO SSH (PARA HACKEAR)
**Windows (PuTTY):**
1. Abra PuTTY
2. Host Name: [IP_DA_VM]
3. Port: 2022
4. SSH → Auth → Browse → Selecione `ctf-private-key.ppk`
5. Open
6. Login: root
7. Senha: P@ssw0rd

**Linux/Mac:**
```bash
ssh -i ctf-private-key.ppk -p 2022 root@[IP_DA_VM]
# Senha: P@ssw0rd
```

## PASSO 4: ACESSO ROOTTHEBOX (PARA PONTUAR)
1. Abra navegador: `http://[IP_DA_VM]:8888`
2. **Login Admin:** admin / rootthebox
3. **Criar conta jogador:**
   - Clique "Registration"
   - Preencha dados
   - Crie conta

## PASSO 5: COMO JOGAR
1. **SSH nas VMs** → Explore e encontre flags
2. **RootTheBox** → Submeta flags e ganhe pontos
3. **Flags** têm formato: `FLAG{texto_aqui}`

## RESUMO RÁPIDO
- **SSH:** `ssh -i ctf-private-key.ppk -p 2022 root@[IP]` (senha: P@ssw0rd) → Para hackear
- **Web:** `http://[IP]:8888` → Para pontuar
- **Chave:** `ctf-private-key.ppk` → Para PuTTY