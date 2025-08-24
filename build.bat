@echo off
setlocal enabledelayedexpansion

REM 删除 dist 目录下的所有文件
rm -r dist/*

REM 1. 在 master 分支构建项目
echo Building project in master branch...
shiroa build --path-to-root /Cloud-Computing/
if errorlevel 1 (
    echo Error occurred during build.
    exit /b 1
)

REM 2. 清理无效的 worktree 引用
git worktree prune

REM 3. 检查并设置 gh-pages 工作树
if not exist gh-pages\.git (
    REM 如果 gh-pages 目录不存在或不是一个 worktree，则创建
    if exist gh-pages rmdir /s /q gh-pages
    echo Creating gh-pages worktree...
    git worktree add -B gh-pages gh-pages
    if errorlevel 1 (
        echo Failed to create worktree.
        exit /b 1
    )
) else (
    echo Using existing gh-pages worktree...
    cd gh-pages
    git checkout gh-pages
    cd ..
)

REM 4. 强制重置 gh-pages 分支到初始状态
cd gh-pages
echo Resetting gh-pages branch to initial state...
git fetch origin gh-pages --depth=1
git reset --hard origin/gh-pages
git clean -fdx

REM 5. 清空 gh-pages 工作树目录（保留 .git）
echo Cleaning gh-pages directory...
git rm -rq --ignore-unmatch *
if errorlevel 1 (
    echo Warning: Failed to clean some files, possibly due to local changes. Trying to proceed...
)

REM 6. 将 dist 内容复制到 gh-pages 工作树
echo Copying dist files...
robocopy ..\\dist . /MIR /NFL /NDL /NJH /NJS /XF .git* >nul
if errorlevel 8 (
    echo Error copying files.
    cd ..
    exit /b 1
)

REM 7. 提交并推送 gh-pages 分支
echo Committing changes with a single commit...
git add --all
git commit --amend -m "Automated deployment: %date% %time%" --allow-empty
if errorlevel 1 (
    echo No changes to deploy.
) else (
    echo Pushing to gh-pages...
    git push origin gh-pages -f
)
cd ..

REM 8. 清理工作树 (可选，如果希望每次都清理)
git worktree remove gh-pages --force

echo Deployment completed successfully.
endlocal
