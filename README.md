# GA WDI Create Github Repositories
This will create a github repository for homework and quizes. It will:

1. Copy a template for each repo, homework or quiz. This will populate the repo with a Gemfile, .gitignore, .travis.yml, Guardfile, and README.md files.
	* The Gemfile will contain the rspec, pry, pry-debugger, simplecov, gaurd-rspec and dotenv gems.
2. Generate a .rvmrc that will create or use an rvm gemset that will have the same name as the repository. *This rvm gemset is where your project gems are installed*
3. Create this repository in your github account.
4. Run the git init, add, commit and remote commands to initialize this repository.

### Prereqs
- Create a github Personal Access Token, [Personal Access Token](http://github.com/settings/applications). *This will allow access to your github account for this application.*
-  Add this personal access token to your .env file. 

	`GITHUB_ACCESS_TOKEN='your token'`


### Install
	$ bundle install

### Create a homework repository
- Create a github repository for homework.

	`$ bin/make_hw_repo *\<repo name\>*`
- Create a github repository for a homework

	`$ bin/make_quiz_repo *\<repo name\>*`
- Help 

	 `$ bin/make_hw_repo help`	 
	 `$ bin/make_hw_repo help create`	 
	 `$ bin/make_hw_repo help copy`	 
	 `$ bin/make_hw_repo help clean`

### Create a quiz repository
- Create a github repository for a quiz.

	`$ bin/make_quiz_repo *\<repo name\>*`
- Help 

	 `$ bin/make_quiz_repo help`	 
	 `$ bin/make_quiz_repo help create`	 
	 `$ bin/make_quiz_repo help copy`	 
	 `$ bin/make_quiz_repo help clean`
                                                                                                                                       

