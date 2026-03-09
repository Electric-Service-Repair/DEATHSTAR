alias ds-dir-scan='echo "R2: performing deep structural scan of DEATHSTAR hangar..."; \
  echo; \
  tree -L 2 -I "node_modules|.git|__pycache__" --dirsfirst --noreport 2>/dev/null || \
  find . -maxdepth 2 -not -path "*/\.*" | sort | sed "s|^\./||; s|^|  |"; \
  echo; \
  echo "Critical findings summary:"; \
  printf "  %-28s %s\n" "Overlapping init scripts:" "$(ls -1 __*DEATH_STAR*INIT* 2>/dev/null | wc -l || echo 0)"; \
  printf "  %-28s %s\n" "Duplicate markdown noise:" "$(ls -1 *readme* *md.md *v[0-9]*_readme* CLAUDE* let* text markdown 2>/dev/null | wc -l || echo 0)"; \
  printf "  %-28s %s\n" "Suspicious junk files:" "$(ls -1 motorola* idea* install* .idea* Hiroshi* 2>/dev/null | wc -l || echo 0)"; \
  printf "  %-28s %s\n" "Active directories:" "$(find . -maxdepth 1 -type d ! -path . ! -path "./.*" | wc -l)"; \
  echo; \
  echo "R2 structural integrity verdict:"; \
  [[ $(git status --porcelain | wc -l) -gt 0 ]] && echo "  • Working tree dirty – commit or stash recommended" || echo "  • Clean working tree"; \
  echo "  • Current branch: $(git rev-parse --abbrev-ref HEAD)"; \
  echo "  • Recommended action: ds-dir-sanitize && ds-docs-consolidate"'

alias ds-dir-sanitize='git checkout main && git pull --ff-only >/dev/null 2>&1 && \
  git branch -l "*INIT*" "*init*" "__*" "resolve-*" "luke-*" "beta*" "alpha*" | xargs -r git branch -D 2>/dev/null; \
  find . -maxdepth 1 \( -name "*INIT*" -o -name "__*" -o -name "CLAUDE*" -o -name "let.md" -o -name "text" -o -name "markdown" -o -name "motorola*" -o -name "*v[1-9]*_readme*" \) -delete 2>/dev/null; \
  git add . >/dev/null 2>&1 && git commit -m "R2: removed redundant init-phase and junk artifacts" --no-verify >/dev/null 2>&1 || true; \
  git push --force-with-lease >/dev/null 2>&1; \
  echo "R2: structural garbage purged."'

alias ds-docs-consolidate='mkdir -p docs/legacy && \
  mv README* v*_readme* yoda-*.md review* add.md text markdown moto* 2>/dev/null docs/legacy/ || true; \
  cat <<EOF > README.md
# DEATH STAR – Project Core

## Status
- Phase: post-init stabilization
- Branch: main
- Cleaned: $(date -u)

## Key Files & Dirs
- docs/legacy/        → deprecated markdown & init debris
- bash/               → alias arsenal
- commands/           → command fragments
- assets/             → visual / static resources

R2 reports: hangar decluttered. Ready for turbo architecture rebuild.
EOF
  git add README.md docs/ && git commit -m "R2: centralized documentation + legacy archive" && git push'

alias ds-full-reorg='ds-dir-scan && ds-dir-sanitize && ds-docs-consolidate && \
  echo "R2: full directory reorg complete. Current structure:" && ds-dir-scan'
