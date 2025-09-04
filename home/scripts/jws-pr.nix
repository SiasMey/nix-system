{pkgs}:
pkgs.writeShellScriptBin "jws-pr" ''
  set -e

  TITLE=$1
  SUMMARY=$2

  TICKET=$(echo $WS_BOOKMARK | grep -oe 'uxi-[0-9]\+' | tr '[:lower:]' '[:upper:]')

  TMPFILE=$(mktemp)
  trap 'rm -f "$TMPFILE"' SIGTERM SIGINT EXIT

  jws-bs
  echo "## Description" > $TMPFILE
  echo "" >> $TMPFILE
  echo $SUMMARY >> $TMPFILE
  echo "" >> $TMPFILE
  jj pr-summary >> $TMPFILE
  echo "" >> $TMPFILE
  echo "" >> $TMPFILE
  echo "## Related Issue(s)" >> $TMPFILE
  echo "" >> $TMPFILE
  echo "- <https://jira.arubanetworks.com/browse/$TICKET>" >> $TMPFILE

  gh pr create -H "$WS_BOOKMARK" -t "$TITLE" -F "$TMPFILE"
''
