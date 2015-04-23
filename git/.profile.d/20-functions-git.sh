# git/.profile.d/20-functions-git.sh
maybe_git_repo()
{
  # assume https if input doesn't contain a protocol
  proto=https
  destination=${HOME}/src
  echo "${1}" | grep '://' > /dev/null 2>&1
  [ $? = 0 ] && proto=$(echo "${1}" | sed -e 's|[:]\/\/.*||g')
  git_dir=$(echo "${1}" | sed -e 's|.*[:]\/\/||g')

  # strip user@, :NNN, and .git from input uri's
  repo="${destination}/"$(echo "${git_dir}" |
    sed -e 's/\.git$//g' |
    sed -e 's|.*\@||g' |
    sed -e 's|\:[[:digit:]]\{1,\}\/|/|g' |
    tr -d '~')

  if [ ! -d "${repo}" ]; then
    mkdir -p "${repo}"
    echo "git clone ${proto}://${git_dir} ${repo}"
    git clone "${proto}://${git_dir}" "${repo}"
    ${cmd}
    if [ $? != 0 ]; then
      # Try removing up to git_dir at worst empty directories.
      # Cheap trick, but oldies are goodies.
      (
        repo_dir="${repo}"
        until [ "${repo_dir}" = "${destination}" ]; do
          cd "${repo_dir}" > /dev/null 2>&1
          rmdir "${repo_dir}" > /dev/null 2>&1
          repo_dir=$(echo "${repo_dir}" | sed -e 's/\/[^\/]*$//g')
        done
      )
      echo "git clone of ${proto}://${repo} failed"
    fi
  fi
  [ -d "${repo}" ] && cd "${repo}"
}

gh()
{
  maybe_git_repo "https://github.com/${1}"
}

bb()
{
  maybe_git_repo "https://bitbucket.org/${1}"
}
