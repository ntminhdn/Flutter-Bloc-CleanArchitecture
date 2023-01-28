@echo off
echo "Checking commit message..."
set commit_message=%~1

(echo %commit_message% | findstr /R /C:"^[[]NFT-[0-9]][ ][a-z0-9_-]*") || (
    echo Commit message "%commit_message%" is invalid. See example: "[NFT-2] some text"
    exit 1
)

echo Commit message "%commit_message%" is valid
