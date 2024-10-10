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


# Can I use this template?

Just like `awesome-cv`, you can write your own resume using this project.
However, unlike the former repository, this code is not currently as generic and
I can't guarantee that everything will automatically look good. I had to do many
small adjustments to get the rendering I was looking for, so I can't guarantee
you won't have to do the same.
