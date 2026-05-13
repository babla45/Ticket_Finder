# Railway Cartesian Product URL Generator

A PowerShell (`.ps1`) tool that automatically generates and opens Bangladesh Railway e-ticket search URLs using Cartesian products between station groups.

This program reads station groups from a text file, supports dynamic travel date selection (current day + 10 days), and allows the user to select combinations.

---

## Features

* **Dynamic Dates:** Automatically generates the next 10 days of dates for selection.
* **Pre-defined Groups:** Load available groups dynamically from `groups.txt`.
* **Custom Matrix Selection (`cm`):** Dynamically build temporary groups from a visual matrix of all stations (supports index ranges, e.g., `1-5`).
* **Cartesian Product Generator:** E.g., `1 2x5` searches every station in Group 2 against every station in Group 5 for Date Index 1.
* **Smart Parsing:** Automatically handles station names separated by commas or spaces and properly URL-encodes them.
* **Auto-Opening:** Safely opens all generated URLs in Microsoft Edge tabs.

---

## File Structure

```text
project/
│
├── ticket_finder.ps1
├── groups.txt
└── README.md
```

---

## groups.txt Format

One group per line. Stations inside a group can be separated by commas or spaces.

Example:
```text
Khulna
Jashore,Mubarakganj,Kotchandpur
Bheramara Ishwardi Natore Santahar
Akkelpur,Joypurhat
Birampur,Fulbari Parbatipur Saidpur
```

---

## How To Run

1. Open PowerShell and navigate to the folder.
2. Run the script:
   ```powershell
   .\gui.ps1
   ```
3. The program will display the **next 10 days** and the **available groups**.

### Basic Usage

When prompted `Enter date index and combination (example 1 2x3) or 'cm' for custom`:
- To select Date #2, and compare Group 1 to Group 3, type: `2 1x3`

### Custom Matrix Mode

If you don't want to use predefined groups:
1. Type `cm` and press Enter.
2. The script lists all unique stations in a clean 5-column table.
3. It asks for two custom groups, formatted as indexes separated by a comma.
   - Example Input: `1 3 5-7, 8 10`
   - Group 1 becomes stations at index 1, 3, 5, 6, 7.
   - Group 2 becomes stations at index 8 and 10.
4. Enter the date index and product (e.g., `2 1x2`) targeting your temporarily generated custom groups!

---

## URL Format

Generated URLs are correctly encoded and follow:
```text
https://eticket.railway.gov.bd/booking/train/search?fromcity=SOURCE&tocity=DESTINATION&doj=DATE&class=S_CHAIR
```

---

## Configuration

Inside the `gui.ps1` script, you can change:
- `$class = "S_CHAIR"`  (Travel class)
- The browser being launched: `Start-Process "msedge"` (change to `"chrome"` or `"firefox"`)
- Tab opening delay: `Start-Sleep -Seconds 1`

---

## Requirements

* Windows
* PowerShell
* Microsoft Edge (default)
