## 🚀 About

Awesome-CV-Timeline is a latex resume template built on top of [awesome-cv](https://github.com/posquit0/Awesome-CV).

Features:
- Focus on the front page
- Column layout
  - [Right]: Experiences, education, projects
  - [Left]: Personal info, skills, keywords
  - Separator: simple timeline with emphasis on internal evolution

## 📝 How does it look?

Here's an example of the output:
![resume-1](https://github.com/Slyces/resume/assets/22822015/532e6663-8bed-4b9f-bc7f-d74686b35d77)

## ⚡️ Quick Start

### 😅 I am a Latex beginner - I want to change the text, keep the looks


```bash
git clone https://github.com/slyces/awesome-cv-timeline resume && cd resume
cp -r examples/single-page private    # Copy the example
cd private                            # Go in the folder
make build                            # Build the example (using latexmk)
open build/resume.pdf                 # Look at the output
```

> [!TIP]
> If you want to see the output of your changes live, you can also run
> `make preview`

Here you go! Now, you have your own copy of the example and you can start replacing information with yours. Your code is not checked into git, so there's no risk of leaking your personal information.

If you find yourself wanting to change how things look, or you're interested in _versioning_ your resume, keep reading! Otherwise, happy tinkering, and good luck with the job search ;)

### <picture><source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/980f1923-2432-47c3-990d-33c269b56ab2"><img src="https://github.com/user-attachments/assets/53e4f075-5b98-486f-be00-6d2ebab13c9f" width="20"></picture> I am a <picture><source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/091d3468-c74b-42a5-9124-c33e17b864b9"><img src="https://github.com/user-attachments/assets/95f84d08-653b-4c00-9f7f-f48d004dd149" width="45"></picture> archwizard

There is a single class file, `resume.cls` with some associated fonts in
`fonts/`. You are welcome to edit this file directly, but if you manage to add
the features that you'd like in a modular way (the `.cls` provides the
functionality but it can be opt-in through the main tex file), I would welcome
any contribution.

## Versioning - How do I keep my data private

The main problem with resumes is that you usually don't want the source to be
available to the public on github. So most people will just copy a template at
some point (in overleaf or a private git) and forget about the original
repository.

In this repository, I tried to provide a structure that allows you to work on
your private data while keeping the upstream (this repository) to either pull in
new features or push your contributions.

### I don't want upstream changes - Let me clone and never come again

If you don't need any future improvement with the template or don't want to
provide some yourself, you can just copy the main level code to a new private
repository or overleaf and delete the files you don't need (`examples/`,
`README.md`, ...).

Your structure should look something like this:
```text
.
├── LICENCE
├── Makefile
├── README.md
├── fonts/
│  └── ...
├── build/
│  ├── resume.pdf        # <- your output
│  └── ...
├── resume.cls           # <- styling
├── resume.tex           # <- main file
└── sections             # <- any subfiles to organise
   ├── experience.tex
   ├── ...
   └── skills.tex
```

### I want to keep upstream updates - and I like git

In order to keep compatibility with future upstream changes, you need to
structure your resume in a folder, like so:
```
.
├── LICENCE
├── Makefile
├── private                      # <- default name in .gitignore
│  ├── build
│  │  ├── ...
│  │  └── resume.pdf
│  ├── Makefile -> ../Makefile   # <- this is a symlink
│  ├── resume.tex                # <- main file
│  └── sections                  # <- any subfiles to organise
│     ├── experience.tex
│     ├── ...
│     └── skills.tex
├── README.md
└── resume.cls                   # <- this shouldn't change
```

How's that different from before? Well, now, we've isolated your resume in a folder.

This means multiple things:

**You can remove this folder from git**

You can add this folder to `.git/info/exclude` to make sure it's not checked out
into your clone/fork of this repository (the template). It means you won't
publish your private information by mistake, and _as long as you don't edit the
`resume.cls`_ and the _Makefile_ you can pull any future improvements to it.

- By default, `private` is in the `.gitignore` as an example

**You can add this folder to git** _(but not the same one)_
You can create a repository for your main files (the `private` folder above) with `git init`, and associate it with any upstream (public or private, github, self-hosted, ...).

- This allows you to keep your version history however you see fit
- The resume's content is now stored separately from how it looks (not too big
of a deal if you mark down the upstream version you rely on)
- You can also do things like cloning twice the same repository on different
branches, if you need to maintain different flavours at all times (e.g.
different languages)
```
.
├── LICENCE
├── Makefile                     # <- this shouldn't change
├── french
│  ├── Makefile -> ../Makefile
│  ├── resume.tex
│  └── sections
│     └── ...
├── english
│  ├── Makefile -> ../Makefile
│  ├── resume.tex
│  └── sections
│     └── ...
├── README.md
└── resume.cls                   # <- this shouldn't change
```

Try to keep the `Makefile` as a symlink so you have the same experience across different folders, and edit the main level one!

### What if I need to change ...

#### The `Makefile`

The `Makefile` probably won't be perfect until a variety of people and machines
try to run it. Your feedback is welcome, this is why I suggest to keep the
`Makefile` as a symlink. You can either split off from the main `Makefile` (just
copy the content) and fix your issues, or you can contribute a fix upstream.

#### The `.cls`

If you need to change the class file, it probably means one of two things:

##### Existing functionalities are not flexible enough

You found yourself wanting to do "what's currently here" slightly differently,
but there was no configuration for it or the setting is not really accessible
from the `resume.tex` file.

This means that we can probably improve the template by making this specific
option configurable in each instance of the template. You can either contribute
a solution or open an issue.

##### I want to do something new

New features are great! If it's just adding a new functionality, we can include
this in the initial template. If you're changing major elements, we could
consider opening a branch with a different flavour of the template, or create
different `.cls`, as long as the "client code" (the content of `resume.tex`) is
identical between different branches/templates and one can keep the content but
change the style.
