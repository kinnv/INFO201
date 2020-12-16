#!/bin/bash
# --------------------------------------------------------------------------------
# document here the main bash commands you are using for the server access.  The file contains
# two parts: the first one for the commands you run on your laptop, and the second one for the
# commands on the remote server.
# 
# The question lists give your some guidance what to do and report but you are free to do it
# in a different way.  If you use a graphical frontend instead of scp for copying files,
# just say which one in the appropriate place.
#
# Note: this file does not to be runnable
#
# -------------------- local commands --------------------
# 1. create a directory for this project.

  #cd ~/desktop/info201
  #mkdir a5-remote-server


# 2. log onto the server

  #ssh vongkin@info201.ischool.uw.edu

# 3. copy the small data subset from the server to your local machine

  #scp vongkin@info201.ischool.uw.edu:/opt/data/temp-prec-tiny.csv.bz2 .

# 4. copy your R-script to the server

  #scp maps.R vongkin@info201.ischool.uw.edu:scripts/

# 5. (after succesfully running the script remotely): copy the output files back to your computer

  #scp vongkin@info201.ischool.uw.edu:scripts/1960p.jpg .
  #scp vongkin@info201.ischool.uw.edu:scripts/1986p.jpg .
  #scp vongkin@info201.ischool.uw.edu:scripts/2014p.jpg .
  #scp vongkin@info201.ischool.uw.edu:scripts/1960t.jpg .
  #scp vongkin@info201.ischool.uw.edu:scripts/1986t.jpg .
  #scp vongkin@info201.ischool.uw.edu:scripts/2014t.jpg .

# 6. inspect that the copy was successful

  #ls


# -------------------- remote commands --------------------
# 1. explore the data directory '/opt/data'.  How do you find out the size of the files?

  #ls -lh

# 2. explore the first few lines of the small sample data

  #bzcat temp-prec-tiny.csv.bz2 | head

# 3. create a directory for this project

  #mkdir scripts

# 4. (after copying your code from the laptop): inspect the files in the project directory

  #cd scripts
  #ls

# 5. run your script

  #Rscript maps.R

# 6. How do you install missing R packages?

  #R
  #install.packages()
  #q()

# 7. (after running the script): inspect the folder for output files

  #ls
