# Architecture

This document describes the high-level design decisions of the Personal VPN project.

It intentionally focuses on **why** the project is structured this way rather than how it is deployed.

---

# Requirements

The primary project requirement is:

> Provide secure remote access through an Israeli IP address.

Secondary requirements include:

* low maintenance
* production-quality deployment
* reproducibility
* strong security
* future extensibility

---

# Why Oracle Cloud?

The project originally explored hosting WireGuard on a home router.

After evaluating the available hardware, Oracle Cloud Infrastructure was selected because:

* the VM is hosted in Oracle's Jerusalem region
* it provides a public static IPv4 address
* no additional hardware is required
* the VM is already running continuously
* the Oracle region geolocates correctly to Israel

This significantly simplifies the deployment while satisfying the project's primary objective.

Should Oracle-hosted VPN traffic become unsuitable for specific services in the future, the architecture allows migration to a home-hosted WireGuard server without changing the overall project structure.

---

# High-Level Architecture

```
                 Internet
                      │
          Oracle Cloud (Jerusalem)
                      │
              WireGuard Server
                      │
           VPN Network (10.77.0.0/24)
          ┌────────────┴────────────┐
          │                         │
      Laptop                    Mobile
```

All client traffic exits through the Oracle VM.

---

# Project Structure

The project intentionally separates source code from runtime configuration.

```
Repository

/opt/personal-vpn

Runtime Configuration

/etc/personal-vpn

Operating System

/etc/wireguard
```

This provides a clear distinction between:

* project assets
* generated configuration
* operating system components

---

# Why Native WireGuard?

Several deployment models were considered.

## Native Linux

Selected.

Advantages:

* direct kernel integration
* simple networking
* straightforward diagnostics
* standard systemd management
* minimal dependencies

## Docker

Rejected.

Although Docker offers portability, it introduces unnecessary complexity for a networking service that already integrates cleanly with Linux.

---

# Security Philosophy

The project follows several security principles.

## Native Linux Security

Use standard Linux security mechanisms whenever possible.

Examples include:

* file permissions
* systemd
* firewalld
* SELinux

## Minimal Exposure

Only the services required for operation should be exposed publicly.

## Key-Based Authentication

WireGuard relies exclusively on public/private key authentication.

Passwords are never transmitted.

## Protected Secrets

Private keys are stored outside the repository and are never committed to version control.

---

# Automation Philosophy

Manual administration does not scale.

Every repetitive task should eventually become a script.

Examples include:

* generating server keys
* adding clients
* removing clients
* backups
* health checks

Scripts should be:

* idempotent
* well documented
* safe to rerun
* predictable

---

# Future Expansion

The project is intentionally designed to support future infrastructure services.

Potential additions include:

* Unbound
* AdGuard Home
* automated backups
* monitoring
* Dynamic DNS
* certificate management

These services should integrate naturally into the existing project structure without requiring architectural changes.

