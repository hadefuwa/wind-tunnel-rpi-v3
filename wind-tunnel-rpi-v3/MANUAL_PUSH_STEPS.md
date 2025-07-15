# Manual Git Push Steps

Since PowerShell execution policy is blocking automated scripts, here are the manual steps:

## Step 1: Open Command Prompt
- Press `Windows Key + R`
- Type `cmd` and press Enter

## Step 2: Navigate to project directory
```cmd
cd /d c:\Users\Adefu\OneDrive\Documents\wind-tunnel-rpi-v3
```

## Step 3: Run git commands one by one
```cmd
git init
git remote add origin https://github.com/hadefuwa/wind-tunnel-rpi-v3.git
git add .
git commit -m "Initial commit: Wind Tunnel Demo - Management Presentation Ready"
git branch -M main
git push -u origin main
```

## Alternative: Enable PowerShell execution then run batch file
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Then double-click `git_push.bat`

## Alternative: Use Git Bash (if installed)
1. Right-click in project folder
2. Select "Git Bash Here"
3. Run: `./git_push.sh`

## What you should see when successful:
```
Enumerating objects: XX, done.
Counting objects: 100% (XX/XX), done.
Delta compression using up to X threads.
Compressing objects: 100% (XX/XX), done.
Writing objects: 100% (XX/XX), done.
Total XX (delta X), reused 0 (delta 0), pack-reused 0
To https://github.com/hadefuwa/wind-tunnel-rpi-v3.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

## If you get authentication error:
- Make sure you're logged into GitHub
- You might need to use a Personal Access Token instead of password
- Go to GitHub Settings > Developer settings > Personal access tokens

Let me know if you encounter any issues!
