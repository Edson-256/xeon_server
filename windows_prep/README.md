# Windows Server Preparation Guide

These scripts help you prepare your Windows Server 2016 for the migration to Ubuntu.

## Step 1: Copy Scripts
Copy the `windows_prep` folder from your Mac to the Windows Server (via RDP, SMB, or USB).

## Step 2: Install Python (Recommended)
This enables the use of modern tools and the Google Gemini SDK.
1. Right-click `install_python.ps1`.
2. Select **Run with PowerShell**.
3. Wait for the "Success" message.

## Step 3: Install Gemini SDK (Optional)
If you want to use Gemini features on Windows before wiping it:
1. Open PowerShell/CMD.
2. Run: `pip install google-genai`

## Step 3.5: Run Gemini Smart Helper (Optional)
This script uses AI to scan your files and generate a migration manifest.
1. You will need your Google API Key.
2. Open PowerShell in this folder.
3. Run: `python smart_backup_helper.py`
4. Follow the prompts. It will save `migration_manifest.txt`. Move this file to the folder you are backing up.

## Step 4: Run Backup
1. **Edit** `backup_routine.ps1` if your files are not in `C:\inetpub\wwwroot`.
    * Right-click > Edit.
    * Change `$SourcePath` to your actual data folder (e.g., `C:\Users\Administrator\Documents\Site`).
2. Right-click `backup_routine.ps1` > **Run with PowerShell**.
3. **CRITICAL**: Copy the generated `.zip` file from `C:\Backup_Migration` to your Mac or a USB drive.

---
**Next Step**: Once you have the ZIP file safe on your Mac, proceed to create the Ubuntu Bootable USB.
