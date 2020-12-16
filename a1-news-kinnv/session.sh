# Print your working directory
pwd

# Change your directory to a folder in which you do work for this class
# Make sure to use the "~" shortcut rather than specifying the full path
cd ~/desktop/info201/

# Clone your private assignment repository from GitHub to your machine
git clone https://github.com/info201b-sp2019/a1-news-kinnv.git

# Change your directory to inside of your "a1-news-USERNAME" folder
cd a1-news-kinnv

# Make a new folder called "imgs" - you'll download an image into this folder
mkdir "imgs"

# At appropriate checkpoints, you'll need to do the following:
# Add all new files you have added (if any) to the git
git add -u
git add imgs

# Make a commit, including a _descriptive_ message
git commit -m "final burning sun scandal summary"

# Push your change up to GitHub
git push origin master
