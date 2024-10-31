## 🚀 About

Awesome-CV-Timeline is a latex resume template built on top of [awesome-cv](https://github.com/posquit0/Awesome-CV).

📘 Features:
- Modern look with a two-column layout
  - _[Left]:_ Personal info, skills, keywords
  - _[Right]:_ Experiences, education, projects
  - _[Separator]:_ simple timeline with emphasis on chronology inside sections
- Main content: sections with job title, company, date and location
  - Detailed experience with bullet points
- Clickable socials
  - Github
  - LinkedIn
  - Email
  - Address
  - ORCID
- Supports images
- Supports multi-pages


## 📝 How does it look?

Here's an example of the output:

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/a9fdf63d-8823-461c-8609-2550fae9d2d9" alt="Page 1" width="400"/>
  <img src="https://github.com/user-attachments/assets/fb442fb0-2d27-48b8-878a-d74007add6ea" alt="Page 2" width="400"/>
</div>

## ⚡️ Quick Start

### 😅 I am a Latex beginner - I want to change the text, keep the looks


```bash
git clone https://github.com/slyces/awesome-cv-timeline resume && cd resume
cp -r examples/multi-pages private    # Copy the example
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

Happy to have you here, please keep reading! I'll go into the details of
advanced usage and how to make sure you can contribute the awesome improvements
you will no doubt implement while playing with this template!

The code heavily comments whatever can be to ensure that you can easily extend
this template and question any given implementation detail if there is a better
way. There is also **plenty** of diagrams in the code.

## 🔒 Versioning - How do I keep my data private

The main problem with resumes is that you usually don't want the source to be
available to the public on github. So most people will just copy a template at
some point (in overleaf or a private git) and forget about the original
repository.

In this repository, I tried to provide a structure that allows you to work on
your private data while keeping the upstream source (this repository) to either
pull in new features or push your contributions.

### 😶 I don't want upstream changes - Let me clone and never come again

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

### 😌 I want to keep upstream updates - and I like git

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

## 🔎 I want to edit the layout

Depending on the content of your resume, the existing layout might not look
good. You might want more or less spacing here and there.

There are two tools provided to you to work on the layout.

### The `debug` flag

In your `resume.tex` you should have the following line:
```
% Enable to see border on tables and other layout indicators
\setbool{debugmode}{true}
```

Once enabled, you should see boxes around stuff, like so:

<p align="center">
  <img src="https://github.com/user-attachments/assets/7f2be11a-c3f0-4b32-bd1a-75e3ce527d6e" alt="Page 1" width="500"/>
</p>

This should help you figure out how different parameters impact the different
components, although I advise you to always look at the production version of
your document to know if it looks good.

### The lengths diagram

The template `resume.cls` has the following diagram to describe the different
lengths available for you to edit (does not include regular latex lengths).

```text
% ┌───────────────────────────────────────────────────────────────────────────┐
% │                                                                           │
% │    ┌ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ┐    │
% │      ↕ \headerbeforeskip                                                  │
% │    │<---------> \headerphotowidth                                    │    │
% │     ┌─────────┐                                                           │
% │    ││         │┌────────────────────────────────────────────────────┐│    │
% │     │         ││                    Name Surname                    │     │
% │    ││ picture ││↕ \headerinterskip                                  ││    │
% │     │         ││             job title - specialisation             │     │
% │    ││         │└────────────────────────────────────────────────────┘│    │
% │     └─────────┘                                                           │
% │    │ ↕ \headerafterskip                                              │    │
% │     ┌───────────────────────────────────────────────────────────────┐     │
% │    ││ Summary                                                       ││    │
% │     └───────────────────────────────────────────────────────────────┘     │
% │    │ ↕ \summaryafterskip                                             │    │
% │     <-------------> \leftcolumnwidth                                      │
% │    │               <---> \leftcolumnrightmargin                      │    │
% │     ╔══════════════╔═══╦═════╗══════════════════════════════════════╗     │
% │    │║Contact       ║   ║  ●  ║Experience                            ║│    │
% │     ║              ║   ║  │  ║↕ \sectioninterskip                   ║     │
% │    │║ϟ     ~~~~~~~~║   ║  ○  ║Company                       Location║│    │
% │     ║ϟ       ~~~~~~║   ║  │  ║Job Title                 start - stop║     │
% │    │║ϟ     ~~~~~~~~║   ║  │  ║• ~~~~~~~~~~~~~         <------------>║│    │
% │     ║ϟ ~~~~  ϟ ~~~~║   ║  │  ║ • ~~~~~~~~~        \datelocationwidth║     │
% │    │║              ║   ║     ║↕ \sectionafterskip                   ║│    │
% │     ║Skills        ║   ║  ●  ║Experience                            ║     │
% │    │║              ║   ║  │  ║                                      ║│    │
% │     ║                  <-> <-> \timelinemargin                      ║     │
```
Eventually this could be combined with the previous debug flag to show them live
on top of actual document you're working with.
