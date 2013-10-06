# GA Create Github Repositories

### Prereqs
- Go [Personal Access Token](http://github.com/settings/applications) and create a Personal Access Token. 
- Add a .env file with this github personal access token
	GITHUB_ACCESS_TOKEN='your token'

### Install
- bundle install

### Create a homework repository
- Usage:                                                                                                                                 
  - make_hw_repo make_hw *\<repo name\>*
  - make_hw_repo make_hw create *\<repo name\>*
- Help 
	- make_hw_repo make_hw help create
	- make_hw_repo make_hw help copy
	- make_hw_repo make_hw help clean

                                                                                                                                       
####Options:                                                                                                                               
  [--verbose]                                                                                                                          

  [--repo-prefix=REPO_PREFIX]                                                                                                          
                               # Default: ga                                                                                           

  [--repo-suffix=REPO_SUFFIX]                                                                                                          
                               # Default: homework                                                                                     
                                                                                                                                       

make a github repository`

