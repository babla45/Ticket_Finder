````md id="readme_md"
# Railway Cartesian Product URL Generator

A Windows Batch (`.bat`) tool that automatically generates and opens Bangladesh Railway e-ticket search URLs using Cartesian products between station groups.

The program reads station groups from a text file and allows the user to select combinations like:

```text
1x5
````

which means:

* every station in Group 1
* paired with every station in Group 5

The generated URLs are automatically opened in Microsoft Edge tabs.

---

# Features

* Dynamic station group loading from `groups.txt`
* Cartesian product generation between groups
* Automatic URL generation
* Opens all generated URLs in Microsoft Edge
* Simple command-line interface
* No hardcoded station lists
* Easy to extend with more groups

---

# File Structure

```text
project/
│
├── gui.bat
├── groups.txt
└── README.md
```

---

# groups.txt Format

One group per line.

Stations inside a group are separated by commas.

Example:

```text
Khulna,Jashore
Mubarakganj,Kotchandpur,Darshana_Halt,Chuadanga
Bheramara,Ishwardi,Natore,Santahar
Birampur,Fulbari,Parbatipur,Saidpur
```

---

# Important Note About Spaces

Batch `for` loops split text using spaces.

So station names with spaces should use:

* underscores `_`
* or `%20`

Example:

```text
Darshana_Halt
```

instead of:

```text
Darshana Halt
```

---

# How To Run

1. Put both files in the same folder:

   * `cartesian_gui.bat`
   * `groups.txt`

2. Double-click:

   * `cartesian_gui.bat`

3. The program will display all available groups.

Example:

```text
1 = Khulna,Jashore
2 = Mubarakganj,Kotchandpur
3 = Bheramara,Ishwardi
```

4. Enter a combination:

```text
2x3
```

5. The script will:

   * generate all route combinations
   * open all URLs in Edge tabs

---

# Example Cartesian Product

If:

Group 1:

```text
Khulna,Jashore
```

Group 5:

```text
Birampur,Fulbari
```

Input:

```text
1x5
```

Generated routes:

```text
Khulna -> Birampur
Khulna -> Fulbari
Jashore -> Birampur
Jashore -> Fulbari
```

---

# URL Format

Generated URLs follow:

```text
https://eticket.railway.gov.bd/booking/train/search?fromcity=SOURCE&tocity=DESTINATION&doj=DATE&class=S_CHAIR
```

---

# Configuration

Inside the batch file:

```bat
set date=23-May-2026
set class=S_CHAIR
```

You can change:

* travel date
* seat class

---

# Browser

The script currently opens links using:

```bat
start msedge
```

You can replace:

* `msedge`
  with:
* `chrome`
* `firefox`
* or another browser

---

# Delay Between Tabs

The script uses:

```bat
timeout /t 1 >nul
```

to avoid browser lag/crashes while opening many tabs.

You can:

* increase delay
* decrease delay
* or remove it

---

# Use Cases

* Railway ticket checking
* Bulk route opening
* Route comparison
* Seat availability monitoring
* Automated ticket search workflows

---

# Requirements

* Windows
* Microsoft Edge installed
* Command Prompt enabled
