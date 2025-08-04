#!/bin/bash

echo "🔧 Fixing 'path:' fields in ks.yaml files..."

find kubernetes/config/kubernetes -name ks.yaml | while read -r file; do
  # Derive relative path to the `app` directory from the Git repo root
  relative_path=$(echo "$file" | sed 's|kubernetes/config/kubernetes/||' | sed 's|/ks.yaml||')/app

  echo "✅ $file -> path: ./$relative_path"

  # Update only the 'path:' line
  sed -i "s|^\([[:space:]]*path:\).*|\1 ./$relative_path|" "$file"
done

echo "✅ All ks.yaml files updated."
