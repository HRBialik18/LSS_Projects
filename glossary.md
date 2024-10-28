# GitHub Glossary

## Git vs. Github
**Git** is a version control system (VCS) that allows you to manage and keep track of your source code history. **Github** is an online (cloud-based) repository hosting platform that uses git.

Github to git is like Steam to PC games

## git vs. gh
In terminal, you’ll see some commands start with ‘git’ and other start with ‘gh’

git: the VCS– you don’t have to use github. You can use BitBucket, Gitlab, etc.

gh: specifically for github

*BitBucket: meant for Atlassian Tools like Jira, Confluence, and more*
*Gitlab: meant for self-hosted environments and enterprises*

### Staging

Let's use an analogy to simplify this. Let's say we have a group project and everyone has their own notebooks with their own research. To make it easier, we decide to make a shared binder where everyone can share their notes.

The shared binder is called a **REMOTE REPOSITORY.** It allows users to add their code from their local computers to the shared repository on cloud.

Git uses staging, which means marking changes in the working directory to be included in your next commit.

Staging is a process that allows you to mark changes for git to track which changes you want to be included in your snapshot. You're deciding which notes can go in the binder.

*Staging Area*: A part of your local repo that is a temporary location where you can review code before adding it in. After reviewing your changes, you can commit them to make it official.
	Think of it like a review section of your research binder. Before adding your notes to the final research, you put them in the review section to decide what should be included. Once you're ready, you can move the notes from the review section to the finalized section (commit).


## Terminal Commands for Github

### Setting up & Initializing

| command | use | analogy scenario |
| ------- | ------- | ---------------- |
| git config --global user.name "[firstname lastname]" | Sets up the name that you use whenever you commit a change to a repository. If you save your changes, it will be under the name you put in so when people refer they can see its YOUR changes. | Sgning your name on your homework before turning it in, so everyone knows it's your work. |
| git config --global user.email "[email]" | Sets up the email address/account that is associated with your changes in the repository. | It's like registering your contact information with your team so everyone knows how to reach you if needed. |
| git init | Initialize an existing directory as Git Repository. | Creating a new project binder from scratch, so you have a place to store and organize your work. |
| git clone [url] <br> gh repo clone [Organization/Repository] | Clone the repository from cloud to your local host, including history and metadata. Changes locally will have to be pushed to cloud to update the repo. | You make a copy of your friends book, including annotations and extra details your friend wrote into the book |

### Updating and Sharing

Before I get into syntax, let's address definitions. We talked about staging areas being a temporary holder:

**add**: You add the changed files into your staging area.

**commit**: Saves the staged changes to your LOCAL repository. It creates a *snapshot* of the repository in its current state.

**push**: Sends your local committed changes to the remote repository. The staging area is now empty.

| command | use | analogy scenario |
| ------- | ------- | ---------------- |
| git remote add [alias] [url] | This command lets you connect your personal code to the shared repository. The 'git remote add' part tells Git you want to add a new connection to the remote repository with the nickname '[alias]'. The URL is the location of the shared repository. | i dont have a good scneario for this |
| git fetch [alias] | Let's say your friend updated the repo and you want to review the changes before putting them in your code. You use 'git fetch' to get the latest updates from the remote repo and the '[alias]' is the same nickname from when you added the repository in the previous command. However, git fetch DOES NOT add the changes to your code automatically. | You and your friend have a lab report in Google docs, and your friend edits the report in suggesting mode instead of editing directly |
| git merge [alias]/[branch] | Let's say you reviewed their code and you're ready to integrate that code to your code. Git merge does just that-- it adds the changes to your code. | You took your friend's updated research and adding it to your own notes to have a complete set. |
| git pull | This basically does the work of git fetch and git merge in one command. It's when you know for sure that your friend's code is good and you want to add it to your repository. | You directly copied the updated notes from a friend into your own binder without checking them first. |
| git add [filename] | This command adds the specific changed file you're referencing to in [filename] to the staging area. You're adding your new notes/changes into the temporary section of the binder. | It's like placing a specific page into the "to be added" section of your project binder. |
| git add . | This command adds all the files that you changed to the staging area. The '.' is what makes it ALL the files you've changed. | It's like taking all your recent work and placing it in the "to be added" section of your binder at once. |
| git push [alias][branch] | Now you've coded a function and you want to add that to the online repo. You use git push to add your code.| You're sending your completed project section to a group member so they can add it to the main binder. |
| git commit -m "[message]" | Commits your current content as a new commit with a message to add context. Whenever you commit, it's a good idea to add a message for context to explain what you're committing. | You're writing a note to yourself about what you just added to your project so you can remember later. |
| git head | git head tells you which commit you're working on. | You're using a bookmark to keep track of the page you're currently working on in a book. |

**Do NOT push to Main!** 
- you can break the code
- you skip the review process
- people can't trace the history of changes

Feedback is essential in the world of collaboration, and Pull Requests let you get that feedback. 
**PULL REQUEST (PR)**: A request to pull from local repo to main. Changes are pushed to a different branch, you open a PR, and people can review your code before it's added into the repository


### History & Branches

GitHub uses *branches* to create separate lines of development in a repository. Let's say we want each team to work on separate parts of the project without interfering with each other's work. We create separate sections for each member's contributions. It keeps it clean, organized, and allows for fixing bugs or adding features.

It's also safer because you don't risk harming: 
- the main code
- the build (how the code is compiled or assembled)
- the deployment (how the code is launched or made live)

The *Main* branch is the branch with all the finalized code and details. 

| command | use | analogy scenario |
| ------- | ------- | ---------------- |
| git branch -a | See all the branches (local & remote). The branch you are currently working is marked with a *. | You're looking at a table of contents to see all the sections of a book and identifying the one you're currently on. |
| git branch [branch-name] | Create a new branch at the current commit. Basically, it's like adding a new section at the same place you're working on. It does not change the current section. | Starting a new chapter in your book while keeping your place in the current chapter. |
| git checkout [branch-name] | Switch to another branch. | Flipping to a different section of your book to work on another part of the project. |
| git merge [branch] | Merge the branch into your current one. You're combining two sections of the binder to get one section of combined code/info. You would usually find yourself merging your own branch into the main branch. | You're combining two sections of your project binder into one complete section. |
| git log | This shows all commits in your current branch's history. | It's like flipping through the pages of your notebook to see all the notes you've written so far. |
|git switch [branch-name] | Switch to [branch-name] | You flip to a different chapter in the book|
| git status | Shows the current state of your project, listing changes that are staged, unstaged, and untracked. This helps you see where your files currently are. | It's like checking your desk to see which papers are ready to go into the binder, which are still being worked on, and which haven't been organized yet. |
| git rm [filename] | Deletes a file from both your project repository (binder) and your local workspace (desk), helping you keep your project tidy and up-to-date. | It's like throwing away a draft of your notes that you no longer need, both from your desk and the project binder. |

Branch, switch, and checkout all have similar functions but key differences
- 'git branch BRANCH_NAME': creates a new branch called BRANCH_NAME but leaves you on the same branch (stay where you are)
- 'git checkout-b BRANCH_NAME': you create a new branch called BRANCH_NAME and you switch to it so you're in the new branch
- 'git switch BRANCH_NAME': you switch to BRANCH_NAME. Nothing is created


### Conflicts

A Merge conflict is an issue that occurs when changes in different branches cannot be automatically merged. It's like having two team members who made different changes to the same section of the binder, requiring discussion to decide which version to keep.