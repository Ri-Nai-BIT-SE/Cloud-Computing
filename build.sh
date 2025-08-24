#!/bin/bash

# 启用错误时退出
set -e

# 删除 dist 目录下的所有文件
echo "Cleaning dist directory..."
rm -rf dist/*

# 1. 构建项目
echo "Building Cloud Computing project..."
shiroa build --path-to-root /Cloud-Computing/
if [ $? -ne 0 ]; then
    echo "Error occurred during build."
    exit 1
fi

echo "Build completed successfully."

# 如果需要部署到 GitHub Pages，可以参考以下代码：
# 2. 清理无效的 worktree 引用
# git worktree prune

# 3. 检查并设置 gh-pages 工作树
# if [ ! -d "gh-pages/.git" ]; then
#     # 如果 gh-pages 目录不存在或不是一个 worktree，则创建
#     if [ -d "gh-pages" ]; then
#         rm -rf gh-pages
#     fi
#     echo "Creating gh-pages worktree..."
#     git worktree add -B gh-pages gh-pages
#     if [ $? -ne 0 ]; then
#         echo "Failed to create worktree."
#         exit 1
#     fi
# else
#     echo "Using existing gh-pages worktree..."
#     cd gh-pages
#     git checkout gh-pages
#     cd ..
# fi

# 4. 强制重置 gh-pages 分支到初始状态
# cd gh-pages
# echo "Resetting gh-pages branch to initial state..."
# git fetch origin gh-pages --depth=1
# git reset --hard origin/gh-pages
# git clean -fdx

# 5. 清空 gh-pages 工作树目录（保留 .git）
# echo "Cleaning gh-pages directory..."
# git rm -rq --ignore-unmatch * || echo "Warning: Failed to clean some files, possibly due to local changes. Trying to proceed..."

# 6. 将 dist 内容复制到 gh-pages 工作树
# echo "Copying dist files..."
# cp -r ../dist/* . 2>/dev/null || true
# if [ $? -gt 1 ]; then
#     echo "Error copying files."
#     cd ..
#     exit 1
# fi

# 7. 提交并推送 gh-pages 分支
# echo "Committing changes with a single commit..."
# git add --all
# current_time=$(date "+%Y-%m-%d %H:%M:%S")
# git commit --amend -m "Automated deployment: $current_time" --allow-empty
# if [ $? -ne 0 ]; then
#     echo "No changes to deploy."
# else
#     echo "Pushing to gh-pages..."
#     git push origin gh-pages -f
# fi
# cd ..

# 8. 清理工作树 (可选，如果希望每次都清理)
# git worktree remove gh-pages --force

echo "Build process completed successfully."
