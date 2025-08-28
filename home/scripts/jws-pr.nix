{pkgs}:
pkgs.writeShellScriptBin "jws-pr" ''
  set -e

  TITLE=$1

  COMMIT_SUMMARY=$(jj pr-summary)
  PR_DESCRIPTION="$COMMIT_SUMMARY\n\nAdd ticket link"

  gh pr create -H $WS_BOOKMARK -t $TITLE -b $PR_DESCRIPTION
''
