# git/.profile.d/20-functions-git.sh

_git_repo_add()
{
  proto=${1}
  where=${2}
  location=${3}
  repo=$(echo ${HOME}/Developer/${where}/${location} | sed -e 's/\.git$//g')
  [[ ! -d ${repo} ]] && mkdir -p ${repo}
  git clone ${proto}://${where}/${location} ${repo}
}

_git_https_repo_add()
{
  _git_repo_add https $*
}

_git_http_repo_add()
{
  _git_repo_add http $*
}

_git_git_repo_add()
{
  _git_repo_add git $*
}

gh()
{
  _cd_git_repo https github.com ${1}
}

bb()
{
  _cd_git_repo https bitbucket.org ${1}
}

_cd_git_repo()
{
  proto=${1}
  where=${2}
  what=${3}
  repo=$(echo "Developer/${where}/${what}"| sed -e 's/\.git$//g')
  full_repo=${HOME}/${repo}
  [[ ! -d ${full_repo} ]] &&  _git_repo_add $*

  if [[ $? != 0 ]]; then
    # Try removing up to ~/Developer at worst empty directories.
    # Cheap trick, but oldies are goodies.
    (
      until [[ ${full_repo} == "${HOME}/Developer" ]]; do
        cd ${full_repo} > /dev/null 2>&1
        rmdir ${full_repo} > /dev/null 2>&1
        full_repo=$(echo ${full_repo} | sed -e 's/\/[^\/]*$//g')
      done
    )
  fi

  [[ -d ${full_repo} ]] && cd ${full_repo}
}
