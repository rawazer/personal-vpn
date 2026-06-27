# Personal VPN Infrastructure

A production-grade WireGuard VPN hosted on Oracle Cloud Infrastructure (OCI) in the **Jerusalem** region.

The goal of this project is to provide secure remote access to the Internet through an Israeli IP address while maintaining production-quality engineering practices.

---

# Project Goals

* Secure remote access from anywhere in the world
* Israeli Internet egress
* Infrastructure-as-Code principles
* Reproducible deployment
* Automated management
* Comprehensive documentation
* Easy disaster recovery

This repository intentionally prioritizes maintainability over quick setup. Every script is designed to be idempotent, documented, and safe to rerun.

---

# Repository Layout

```
personal-vpn/

├── docs/
│   ├── Architecture.md
│   ├── Deployment.md
│   ├── Operations.md
│   ├── Security.md
│   └── Troubleshooting.md
│
├── scripts/
│   ├── common.sh
│   ├── check-prerequisites.sh
│   ├── generate-server-keys.sh
│   └── ...
│
├── templates/
│
├── clients/
│
├── backups/
│
├── Makefile
└── README.md
```

---

# Runtime Layout

The repository is separate from the deployed configuration.

```
Repository

/opt/personal-vpn

↓

Deployment

/etc/personal-vpn
/etc/wireguard
```

This separation allows:

* version-controlled project files
* protected runtime configuration
* reproducible deployments
* straightforward backups

---

# Engineering Principles

The project follows several guiding principles.

## Simplicity

Choose the simplest architecture that satisfies the requirements.

## Idempotency

Deployment scripts should be safe to execute multiple times.

## Least Privilege

Only scripts that modify the operating system require root privileges.

## Documentation First

Every significant design decision should be documented.

## Standard Linux Integration

Whenever practical, prefer native Linux mechanisms over custom solutions.

Examples include:

* systemd
* firewalld
* WireGuard
* standard filesystem hierarchy

---

# Current Status

This project is currently under active development.

See `docs/Architecture.md` for the overall design.

