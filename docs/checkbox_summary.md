# SQLI Tools Checkbox Summary

This checklist compares Sqlmap、Ghauri and DSSS performances on different vulnerable web applications.

---

## 1. DVWA (Damn Vulnerable Web Application)

### Low Security
| Tool | SQLi (Error) | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ |
| **Ghauri** | √ | √ | √ | × | √ | √ |
| **JSQL** | √ | √ | √ | √ | √ | √ |
| **DSSS** | × | × | × | × | √ | × |

### Medium Security
| Tool | SQLi (Error) | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ |
| **Ghauri** | × | × | × | × | × | × |
| **JSQL** | × | × | × | × | × | × |
| **DSSS** | × | × | × | × | × | × |

### High Security
| Tool | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ |
| **Ghauri** | × | × | × | √ | √ |
| **JSQL** | × | × | × | × | × |
| **DSSS** | × | × | × | × | × |

---

## 2. bWAPP (buggy web application)

### Low Security
| Tool | Search (Error) | Search (B-blind) | Search (T-blind) | Search (Union) | Blind (B-blind) | Blind (T-blind) | UA (Error) | UA (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ | √ | √ |
| **Ghauri** | √ | √ | √ | × | √ | √ | × | × |
| **JSQL** | √ | √ | × | √ | √ | × | × | × |
| **DSSS** | √ | × | × | × | × | × | × | × |

> **Attension**: bWAPP Medium security probably uses input sanitization, even sqlmap’s payload cannot go through.

---

## 3. Other Targets

### OWASP Juice-shop
| Tool | Search (B-blind) | Search (T-blind) | Login (B-blind) |
| :--- | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ |
| **Ghauri** | × | × | × |
| **JSQL** | × | × | × |
| **DSSS** | × | × | × |

### WebGoat
* In WebGoat SQLi (Advanced) page, **Sqlmap** and **JSQL** successfully found `username_reg` (PUT request) with Boolean-based blind weakness.

---

## Feature of Tools

### Sqlmap
* **High adaptability**: Supports multiple dialects. Scans with heuristic and dynamic approach. Adapts to modern web frameworks.
* **Context-aware**: When escape or encoding is detected, sqlmap will automatically use **Hexadecimal** or `CHAR()` to construct quote-less Payload.
* **Example (Error-based)**:
  `id=1 AND EXTRACTVALUE(1144,CONCAT(0x5c,0x7171626b71,(SELECT (ELT(1144=1144,1))),0x7170717171))&Submit=Submit#`

### Ghauri
* Current version does not support **UNION** based quries.
* Current supported DBMS are limited. Juice-shop uses SQLite so Ghauri cannot conquer it.

### JSQL
* GUI guides rookies through the various options of sqli, help users learn each 'module' of a http request.
* Preset with hard-coded injection logic. Lacks heuristic scanning capability.

### DSSS (Damn Small SQLi Scanner)
* **Super lightweight**: Only supports injection of basic GET/POST requests.
* **Limitation**: Cannot not read request file like Sqlmap and Ghauri do. And its Boolean-based blind injection lacks power. Does not support Time-based blind.

### Why Juice-shop blocks all but Sqlmap?
* OWASP Juice-shop uses a modern API-driven architecture. Its server uses Node.js, express, and RESTful APIs.
* Node.js HTTP parsers drop malformed requests (e.g., raw spaces/quotes in URIs) before they reach the application logic.
* JSON parsing middleware blocks syntax-breaking payloads. Form encoding changed from `application/x-www-form-urlencoded` to `application/json`.