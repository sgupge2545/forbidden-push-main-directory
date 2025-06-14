#!/bin/sh

# .git/hooksディレクトリの作成
mkdir -p .git/hooks

# pre-pushフックの作成
cat > .git/hooks/pre-push << 'EOF'
#!/bin/sh

# プッシュしようとしているブランチを取得
while read local_ref local_sha remote_ref remote_sha
do
    # mainブランチへの直接プッシュをチェック
    if [ "$remote_ref" = "refs/heads/main" ]; then
        echo "================================================"
        echo "# mainブランチへのプッシュは禁止されています。 #"
        echo "================================================"
        exit 1
    fi
done

exit 0
EOF

# 実行権限の付与
chmod +x .git/hooks/pre-push

echo "Gitフックの設定が完了しました。"