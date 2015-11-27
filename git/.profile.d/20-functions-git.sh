# git/.profile.d/20-functions-git.sh
maybe_git_repo()
{
  # assume https if input doesn't contain a protocol
  proto=https
  destination=${HOME}/src
  echo "${1}" | grep '://' > /dev/null 2>&1
  [ $? = 0 ] && proto=$(echo "${1}" | sed -e 's|[:]\/\/.*||g')
  git_dir=$(echo "${1}" | sed -e 's|.*[:]\/\/||g')
  rrepo="${proto}://${git_dir}"

  # strip user@, :NNN, and .git from input uri's
  repo="${destination}/"$(echo "${git_dir}" |
    sed -e 's/\.git$//g' |
    sed -e 's|.*\@||g' |
    sed -e 's|\:[[:digit:]]\{1,\}\/|/|g' |
    tr -d '~')

  if [ ! -d "${repo}" ]; then
    git ls-remote "${rrepo}" > /dev/null 2>&1
    if [ $? = 0 ]; then
      mkdir -p "${repo}"
      echo "git clone ${rrepo} ${repo}"
      git clone "${rrepo}" "${repo}"
    else
      echo "${rrepo} doesn't look to be a git repository"
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
