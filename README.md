
# Awesome Academic CV
This repository is a latex resume built on top of
[awesome-cv](https://github.com/posquit0/Awesome-CV), and the fork [Resume](https://github.com/Slyces/resume) which adds a time line. The fork aims for a single-page resume, but for academics who need to include all publications, projects, etc, there might be a need for more space. This fork keeps the timeline on the subsequent pages, while keeping the sidebar to page-1 only. The following adjustments have been made:

* The address is now clickable and points to Google Maps (from [here](https://github.com/Slyces/resume/commit/84c2f899773472caa878feca2c5ce77a6dffba22)).
* Added ORCID icon to contact details
* Added option for in-line links to github repositories or URL (e.g. web pages)
* Modified the timeline to handle more (sub-)nodes by default (but you have to select them for each page)
* Added biblatex bibliography option (using biber) for selected publications and full publication list
  * The full publication list does not use the textbox environment and can handle printing over multiple pages, at the expense of giving up the timeline.
* Added optional parameter for cventries environment that prints a sub-header (e.g. for splitting up projects per theme)
* Fix a photo alignment (left and right gave picture on the right only)
* Re-added colors of original [awesome-cv](https://github.com/posquit0/Awesome-CV) back to the class, appended the blue from [Resume](https://github.com/Slyces/resume) as `awesome-darkblue`.
* Updated the example resume to demo the additions.

## How to compile?
```
xelatex resume.tex
biber resume
xelatex resume.tex
```

Here's an example of the output:

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/iroghair/aa-resume/blob/7ebbc2017e2436ecbaebf7a077e462a8f5b3dafb/images/pg-1.png" alt="Page 1" width="400"/>
  <img src="https://github.com/iroghair/aa-resume/blob/7ebbc2017e2436ecbaebf7a077e462a8f5b3dafb/images/pg-2.png" alt="Page 2" width="400"/>
  <img src="https://github.com/iroghair/aa-resume/blob/7ebbc2017e2436ecbaebf7a077e462a8f5b3dafb/images/pg-3.png" alt="Page 3" width="400"/>
</div>


## Can I use this template?

Just like `awesome-cv`, you can write your own resume using this project.
However, unlike the former repository, this code is not currently as generic and
I can't guarantee that everything will automatically look good. I had to do many
small adjustments to get the rendering I was looking for, so I can't guarantee
you won't have to do the same.
