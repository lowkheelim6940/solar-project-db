# ☀️ Solar Panel Installation — Database Management System

A relational database project built with **Oracle SQL** to manage the full lifecycle of solar panel installations — from client registration to project tracking, panel assignment, and payment recording.

> Final Project · Database Management Systems Course

---

## 📋 Table of Contents

- [Overview](#overview)
- [Entity-Relationship Diagram](#entity-relationship-diagram)
- [Database Schema](#database-schema)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Sample Data](#sample-data)
- [Design Decisions](#design-decisions)
- [Technologies Used](#technologies-used)

---

## Overview

This project implements a normalized relational database (3NF) for a fictional solar panel installation company. The system tracks:

- **Clients** — customer profiles and contact info
- **Projects** — installation projects with lifecycle status
- **Panels** — individual solar panels with serial numbers and type classification
- **Payments** — financial transactions per project
- **Panel Types** — lookup table for panel efficiency categories (Standard, Premium, Ultra High)

---

## Entity-Relationship Diagram

```
CLIENTS ──────────────────────────────────────────────────────────────┐
│ PK  client_id          NUMBER                                        │
│     first_name         VARCHAR2(50)                                  │
│     last_name          VARCHAR2(50)                                  │
│ UK  email              VARCHAR2(100)                                 │
│     signup_date        DATE                                          │
│     state_code         CHAR(2)                                       │
│     phone_number       VARCHAR2(20)                                  │
└──────────────────────────────────────────┐                          │
                                           │ 1                         │
                                           ▼                           │ 1
                                      PROJECTS ◄─────────────────────┘
                                      │ PK  project_id     NUMBER      │
                                      │ FK  client_id      NUMBER      │
                                      │     project_name   VARCHAR2    │
                                      │     panel_count    NUMBER      │
                                      │     expected_kw    NUMBER      │
                                      │     install_date   DATE        │
                                      │     inspection_date DATE       │
                                      │     status         VARCHAR2    │
                                      └────────────┬────────┬─────────┘
                                              1    │        │ 1
                                          ─────────┘        └─────────
                                          ▼ many                many ▼
                                       PANELS              PAYMENTS
                  PANELTYPES ──►  │ PK panel_id  │     │ PK payment_id │
                  │ PK code    │  │ FK project_id│     │ FK project_id │
                  │    desc    │  │ FK type_code │     │    amount     │
                  └────────────┘  │    capacity  │     │    pay_date   │
                       1 ──► many │    serial_no │     │    method     │
                                  └──────────────┘     │    note       │
                                                        └───────────────┘
```

**Cardinalities:**
| Relationship | Type | Description |
|---|---|---|
| Clients → Projects | One-to-Many | A client may own multiple projects |
| Projects → Panels | One-to-Many | A project contains many panels (cascade delete) |
| Projects → Payments | One-to-Many | A project may have multiple payments (cascade delete) |
| PanelTypes → Panels | One-to-Many | A panel type classifies many panels |

---

## Database Schema

### Tables

| Table | Primary Key | Foreign Keys | Notable Constraints |
|---|---|---|---|
| `clients` | `client_id` | — | `email` UNIQUE, `state_code` CHECK (len=2) |
| `paneltypes` | `panel_type_code` | — | `description` UNIQUE |
| `projects` | `project_id` | `client_id → clients` | `status` CHECK enum, composite UNIQUE `(client_id, project_name)` |
| `panels` | `panel_id` | `project_id → projects` (cascade), `panel_type_code → paneltypes` | `serial_number` UNIQUE, `capacity_kw` CHECK (>0) |
| `payments` | `payment_id` | `project_id → projects` (cascade) | `amount` CHECK (>0), `payment_method` CHECK enum |

### Status Values
- **Projects:** `Planned` · `Installed` · `Inspected` · `Cancelled`
- **Payment Methods:** `Credit` · `ACH` · `Check`

---

## Project Structure

```
solar-project-db/
│
├── sql/
│   ├── schema.sql        # DDL — CREATE TABLE statements with all constraints
│   ├── sample_data.sql   # DML — INSERT statements with representative data
│   └── reset.sql         # DROP statements to reset the database cleanly
│
└── README.md
```

---

## Getting Started

### Prerequisites
- Oracle Database 12c or later
- SQL*Plus, SQL Developer, or any Oracle-compatible client

### Setup Instructions

**Step 1 — Reset (if re-running)**
```sql
@sql/reset.sql
```
> Safely drops all tables using `CASCADE CONSTRAINTS`. Safe to run on a fresh schema.

**Step 2 — Create the schema**
```sql
@sql/schema.sql
```

**Step 3 — Load sample data**
```sql
@sql/sample_data.sql
```

### Verify the setup
```sql
SELECT table_name FROM user_tables ORDER BY table_name;
```

Expected output:
```
CLIENTS
PANELS
PANELTYPES
PAYMENTS
PROJECTS
```

### Quick query to confirm data
```sql
SELECT c.first_name || ' ' || c.last_name AS client,
       p.project_name,
       p.status,
       COUNT(pa.panel_id) AS panels_installed
FROM   clients c
JOIN   projects p  ON p.client_id  = c.client_id
LEFT JOIN panels pa ON pa.project_id = p.project_id
GROUP BY c.first_name, c.last_name, p.project_name, p.status
ORDER BY client;
```

---

## Sample Data

The database is pre-loaded with representative records across all five tables:

| Table | Records | Details |
|---|---|---|
| `clients` | 5 | Clients across CA, NV, AZ, TX, NM |
| `paneltypes` | 3 | STD (Standard), PRM (Premium), ULH (Ultra High Efficiency) |
| `projects` | 5 | Mix of Planned, Installed, and Inspected statuses |
| `panels` | 8 | Distributed across projects using all three panel types |
| `payments` | 5 | Includes multi-payment projects (project 2001 has two payments) |

---

## Design Decisions

### Identity Columns over Sequences
All surrogate PKs use `GENERATED BY DEFAULT AS IDENTITY` (Oracle 12c+), eliminating the need for separate sequence objects while still allowing explicit ID values in `sample_data.sql`.

### Natural Key for PanelTypes
`panel_type_code` uses a natural key (`STD`, `PRM`, `ULH`) rather than a numeric surrogate. This makes FK references self-documenting without requiring a join to understand the value.

### CHECK Constraints over Lookup Tables
`status` and `payment_method` use CHECK constraints rather than separate lookup tables, since both fields have small, stable value sets that are unlikely to grow.

### Cascade Delete on Panels and Payments
Both `panels` and `payments` use `ON DELETE CASCADE` on their project FK. This ensures referential integrity automatically — panels and payments have no independent existence outside their parent project.

### Composite UNIQUE on Projects
`UNIQUE (client_id, project_name)` allows two different clients to share a project name while preventing any single client from having duplicate project names.

---

## Technologies Used

- **Database:** Oracle Database 12c+
- **Language:** SQL (DDL + DML)
- **Oracle-specific features:** `GENERATED BY DEFAULT AS IDENTITY`, `VARCHAR2`, `NUMBER`, `DATE` literals, PL/SQL anonymous blocks (reset script)

---

## Commit History Guide

For the required minimum 10 commits, suggested commit messages:

```
1. Initial commit — project scaffold and README
2. Add schema.sql — clients and paneltypes tables
3. Add schema.sql — projects table with status constraint
4. Add schema.sql — panels table with cascade delete
5. Add schema.sql — payments table with method constraint
6. Add sample_data.sql — clients and paneltypes seed data
7. Add sample_data.sql — projects and panels seed data
8. Add sample_data.sql — payments seed data
9. Add reset.sql — PL/SQL drop script with exception handling
10. Update README — finalize ER diagram and design decisions
```

---

## License

This project was created for academic purposes as part of a Database Management Systems course.
