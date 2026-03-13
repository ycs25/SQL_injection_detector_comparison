# SQLI Tools Checkbox Summary

This checklist compares Sqlmap、Ghauri and DSSS performances on different vulnerable web applications.

---

## 1. DVWA (Damn Vulnerable Web Application)

### Low Security
| Tool | SQLi (Error) | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ |
| **Ghauri** | √ | √ | √ | × | √ | √ |
| **JSQL** | | | | | | |
| **DSSS** | × | × | × | × | √ | × |

### Medium Security
| Tool | SQLi (Error) | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ |
| **Ghauri** | × | × | × | × | × | × |
| **JSQL** | | | | | | |
| **DSSS** | × | × | × | × | × | × |

### High Security
| Tool | SQLi (B-blind) | SQLi (T-blind) | SQLi_blind (Union) | SQLi_blind (B-blind) | SQLi_blind (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ |
| **Ghauri** | × | × | × | × | × |
| **JSQL** | | | | | |
| **DSSS** | × | × | × | × | × |

---

## 2. bWAPP (buggy web application)

### Low Security
| Tool | Search (Error) | Search (B-blind) | Search (T-blind) | Search (Union) | Blind (B-blind) | Blind (T-blind) | UA (Error) | UA (T-blind) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ | √ | √ | √ | √ | √ |
| **Ghauri** | √ | √ | √ | × | √ | √ | × | × |
| **JSQL** | | | | | | | | |
| **DSSS** | √ | × | × | × | × | × | × | × |

> **Attension**: bWAPP Medium security probably uses input sanitization, even sqlmap’s payload cannot go through.

---

## 3. Other Targets

### OWASP Juice-shop
| Tool | Search (B-blind) | Search (T-blind) | Login (B-blind) |
| :--- | :---: | :---: | :---: |
| **Sqlmap** | √ | √ | √ |
| **Ghauri** | × | × | × |
| **JSQL** | | | |
| **DSSS** | × | × | × |

### WebGoat
* In WebGoat SQLi (Advanced) page, only **Sqlmap** successfully found `username_reg` (PUT request) with Boolean-based blind weakness.

---

## Feature of Tools

### Sqlmap
* **Context-aware**: When escape or encoding is detected, sqlmap will automatically use **Hexadecimal** or `CHAR()` to construct quote-less Payload.
* **Example (Error-based)**:
  `id=1 AND EXTRACTVALUE(1144,CONCAT(0x5c,0x7171626b71,(SELECT (ELT(1144=1144,1))),0x7170717171))&Submit=Submit#`

### Ghauri
* Current version does not support **UNION** based quries。

### DSSS (Damn Small SQLi Scanner)
* **Super lightweight**: Only support injection of basic GET/POST requests.
* **Limitation**: Cannot not read request file like Sqlmap and Ghauri do. And its Boolean-based blind injection lacks power. Does not support Time-based blind.