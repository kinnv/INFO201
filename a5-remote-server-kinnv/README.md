# Problem Set 6: Work on a Remote Server

This problem set asks you to complete a task on a _remote server_.
You use your laptop to develop the code and log in to the server,
however, the calculations will be done on the server.

Your task is to plot **temperature and precipitation maps** for **North
America**, for **April** month **1960** (first year in the data), **1986** (in the
middle of the observation period), and **2014** (the last year).
These maps _must be plotted on the server_.

Thereafter, you **create a report** in rmarkdown where you include the
maps and briefly explain the data and your findings.  You also have to
**submit the code**--an R script that you run on the server (must be
run on the server, either from command line or from within R
environment), 
and a **session.sh** file where
you include the shell commands you use on your laptop and on the
server, in similar fashion as in the problem set 1
(this file does not have to be runnable).  The stubs for the three files are
included in the repo.

Finally, you convert your report into html and make it
visible to everyone through _gh\_pages_ branch on github.

Unlike in the previous four problem sets, we do not hold you hand
much.  You are pretty much free to use whatever libraries, variables,
approaches you like as long as the you follow the main steps, listed
above. 

Good luck!


# The Problem

## Detailed Task List

1. Make sure you are familiar with the
   [remote-login appendix](https://otoomet.github.io/book/remote-server.html)
   in the
   book.
   
   You should know how to log in remotely, copy the files from your
   computer to the server and back,
   install packages, and execute R scripts remotely.
 
1. The data is located in `/opt/data`.  There are two
   temperature-precipitation files.  Both have a similar structure.
   You will work with the large one
   (`temp-prec-encrypted`).

   From the command line, inspect the first few lines of data.  This
   contains [NOAA data](https://www.esrl.noaa.gov/psd/data/gridded/data.UDel_AirT_Precip.html) for land surface temperature and precipitation.
   It is a compressed
   file, so you need tools like `bzcat` to print it, you can select
   the first lines with `head` or use pager `more`.  The data contains the following
   variables: _longitude_, _latitude_,
   _time_, airtemp, precipitation.  An example of the data looks like
   this:
```
longitude,latitude,time,airtemp,precipitation
314.75,-14.25,1963-03-01,24.8999996185303,0.830000042915344
315.25,-14.25,1963-03-01,26.1000003814697,0
315.75,-14.25,1963-03-01,27.3999996185303,0
```
   There is one observation for each 0.5 degree of latitude and
   longitude.  Longitude is measured in _degrees east_ (Western hemisphere has
   longitude > 180), Latitude in _degrees north_.  Temperature is the monthly mean (_deg C_),
   precipitation is the monthly sum (_cm_).  The records for sea surface
   are
   there but the values are missing.  There are also some missing values on
   land. 
   
3. The main data files is encrypted.  These can easily be decrypted
   using the `decryptData` function in _decrypt_ library, using
   something like
```{r, eval=FALSE}
decryptedData <- decrypt::decryptData(encryptedData)
```
   _decrypt_ is a dedicated
   library that is already installed on the server.  Note: it is not
   available on CRAN, so you cannot just install in in RStudio.

1. In order to facilitate code development and
   testing, I have included a small test file
   `temp_prec_tiny.csv.bz2` in the same folder.  You may copy that file
   to your computer and use it for developing/testing the code.  This
   data is not encrypted.  Note that this tiny dataset does not cover
   the time nor space extend required for the task, it is made just
   for you to develop the code.
   
   *Pro tip:* Be sure to be on your local machine and **NOT** the
   server when pushing files to the server or pulling those off there. 
   Think about the path that would be required on the server to access the file. 

Do all the following steps in a script file (_maps.R_) is the stub for
the sripts.  Test your script by running it as a script (use _source_
button/Ctrl-Shift-S in RStudio), not line-by-line.  On Mac (and linux)
you can also run it as `Rscript maps.R` at bash prompt.  (for windows
is requires additional configuration). 

1. Select the observations for North America.  You don't have to use
   the exact geographical borders, just broad latitude/longitude
   boundaries will do.  We don't care if you consider Greenland as
   part of Americas or not,
   but don't show all of Africa here!
   
1. Select only observations for April 1960, April 1986, April 2014.

3. In order to conserve the server's memory, delete the original full
   dataset (the one you directly read from file and
   used for filtering years and area) from memory (check
   the `rm` function).

1. Make the maps: plot the longitude versus latitude, and color the
   tiles according to temperature or precipitation.  Do this for all
   the required years.  Make sure you save the plots into a jpg (or png)
   file by using the corresponding graphic device like
   `jpeg("map.jpg")`.  Don't forget to close the device afterwards!
   
   Note: there are many ways to create such maps in R, you may use
   _ggplot_, base R graphics functions, and other libraries.
   
1. Copy the map jpg files you just created from server to your
   laptop.  Remember: `scp` command must be issued on your laptop, not
   on server!

1. Write a brief report as an rmarkdown file where you explain what did you find.  (The
   file _climate\_report.md_ gives you the stub).

1. Fill also out both sections in the `session.sh` file, describing
   which commands did you run.

6. And finally: publish your report on the internet!  Do this using
   GitHub's _gh-pages_ branch (see for instance, [GH
   documentation
   here](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/).
   Note: do this using _gh-pages_, **not through other 
   alternativs** there.  This involves three steps: 
    * create _gh_pages_ branch on your repo
	* knit your report rmarkdown file into html and rename the resulting html into
    _index.html_
    * push your _gh-pages_ branch, and tell GH to publish the
      _gh-pages_ branch ([see explanation
      here](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/)) 

That's it!


## Additional challenge

If you feel you can do a little more, here are a few ideas:

* use a color gradient scale so that negative temperatures (in
  Celsius) are blue and positive ones red
* convert celsius and centimeters to fahrenheits and inches (please
  state that in the legend)
* use a nice map projection.  Look the _ggplot's_ `coord_map()`
  function and the list of projections in _mapproj_ library.  Warning:
  nice projections tend to run slow!


## Notes on the server:

* the server's name is _info201.ischool.uw.edu_

* use your UW netid and password to log on.

* the data is in `/opt/data/`.

* the server should have plenty of disk space (500G), but may be low
  on memory (38G) if many people are working there at the same time.

* if you need to do something with superuser privileges, you have to
  contact Ott.

* it is a virtual machine with dynamic memory, so memory reports may be
  unreliable. 
  


# Grading:

* explore data from command line on server: **4**
    - able to print and filter bz2-compressed files (2)
    - able to use shell pipes and some of the following: pagers,
      head/tail/... (4)
  
* copy data back and forth between the server and the local computer:
  **5**
    - commands/programs are used in a clean and meaningful way. (3)
    - the user understands what (s)he is doing (2)

* run R scripts on server: **5**
    - uses R interactive session instead of `R cmd BATCH`/`Rscript`: -1

* local code, run on laptop on test data: **20**
  **only graded if the main code not done**
    - code does not run: -14
    - messy style: -2
    - unclear comments: -2
    - unclear variable names: -2
  
* main code: **66**
    - code does not run on the server: -50
	- data does not load: -25
	- all plots missing: -25
	- some graphs missing: -10
	- not decrypted: -10
	- graphs do not look good: missing or wrong labels, unclear color
      coding...: -10
	- geographic area incorrect: -10
    - messy style: -3
    - messy/unnecessary comments: -2
    - unclear variable names: -2
    - does not remove big dataset from memory: -5
  
* climate report: **20**
    - (some) figures missing: -5
    - messy/too short (less than 2 sentences) explanations: -5
	- report not published on the internet as
      http://yourusername.github.io/your-repo-name: -4
	- report published through other means, not _gh\_pages_: -1
