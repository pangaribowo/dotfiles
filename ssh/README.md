# SSH Multi-Account Configuration Guide

Panduan setup SSH multi-akun untuk GitHub.

## 1. File Config

Salin `config.example` menjadi `~/.ssh/config`:

```bash
cp config.example ~/.ssh/config
chmod 600 ~/.ssh/config
```

## 2. Generate SSH Key (Jika Belum Ada)

Untuk akun utama:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/id_rsa_main
```

Untuk akun kedua:
```bash
ssh-keygen -t rsa -b 4096 -C "your_second_email@example.com" -f ~/.ssh/id_rsa_secondary
```

## 3. Tambahkan Public Key ke GitHub

Ambil isi public key:
```bash
# Untuk akun utama
cat ~/.ssh/id_rsa_main.pub

# Untuk akun kedua
cat ~/.ssh/id_rsa_secondary.pub
```

Buka **GitHub Settings > SSH and GPG keys > New SSH Key**, lalu paste isinya.

## 4. Test Koneksi

```bash
# Akun utama
ssh -T git@github.com

# Akun kedua
ssh -T git@github.com-secondary
```
