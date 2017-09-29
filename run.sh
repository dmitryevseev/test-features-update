git fetch --all

for BRANCH in `git branch -r | grep 'origin/HUM-*'`;
  do
    echo "Updating: " + $BRANCH
    # Checkout feature branch
    git checkout $BRANCH
    # Merge Master to Branch
    git merge origin/master

    # Check for conflict and ignore branch if they exist
    FILES_IN_CONFLICT=`git diff --name-only master..$BRANCH --diff-filter=U | wc -l`
    if [ "$FILES_IN_CONFLICT" = "0"  ] ;
    then
      # Push merged Branch
      git push origin $BRANCH
      echo "Updated: " + $BRANCH
    else
      # Reset changes to be able to checkout next branch
      git reset HEAD --hard
      echo "Looks like hotfix introduced conflicts( $FILES_IN_CONFLICT ). Please resolve manually"
    fi
  done

