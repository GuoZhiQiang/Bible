#!/bin/bash

# 设置 ebook-convert 路径（Calibre 安装后可能会变）
EBOOK_CONVERT="/Applications/calibre.app/Contents/MacOS/ebook-convert"

# 输出文件名
OUTPUT_NAME="book"

# 清理旧文件
rm -f "$OUTPUT_NAME.md" "$OUTPUT_NAME.epub" "$OUTPUT_NAME.mobi"

echo "📚 合并 Markdown 文件..."

# 合并所有以编号开头的 Markdown 文件
for file in $(ls | grep '^[0-9]\+-.*\.md$' | sort -V); do
    echo "  ➕ $file"
    echo -e "\n\n" >> "$OUTPUT_NAME.md"
    cat "$file" >> "$OUTPUT_NAME.md"
done

echo "✅ 合并完成：$OUTPUT_NAME.md"

echo "📘 转换为 EPUB..."
pandoc "$OUTPUT_NAME.md" -o "$OUTPUT_NAME.epub"

echo "🔁 转换为 MOBI..."
"$EBOOK_CONVERT" "$OUTPUT_NAME.epub" "$OUTPUT_NAME.mobi"

echo "✅ 生成完成：$OUTPUT_NAME.mobi"

# 可选清理中间文件（如不想保留 epub/md，可取消注释）
# rm "$OUTPUT_NAME.md" "$OUTPUT_NAME.epub"

echo "🎉 一键转换完成！请查看：$OUTPUT_NAME.mobi"
