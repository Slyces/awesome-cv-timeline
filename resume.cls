% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
% ==============================================================================
% Resume class forked from awesome-cv (https://github.com/posquit0/Awesome-CV),
% introducing a two-column layout and a « timeline » to present experiences,
% education and projects.
%
% This class is very long. It is split in multiple large sections by long
% « ==== » separators.
\ProvidesClass{resume}[Custom Resume]
\NeedsTeXFormat{LaTeX2e}


% Class Options
% --------------------------------------
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)

% Options for draft or final
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
% Inherit options of article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}


% Packages
% --------------------------------------

% Needed to make fixed length table
\RequirePackage{array}
% Needed to handle list environment
\RequirePackage{enumitem}
% Needed to handle text alignment
\RequirePackage{ragged2e}
% Needed to configure page layout
\RequirePackage{geometry}
% Needed to make header & footer effeciently
\RequirePackage{fancyhdr}
% Needed to manage colors
\RequirePackage{xcolor, luacolor}
% Needed to use \ifxetex-\else-\fi statement
\RequirePackage{ifxetex}
% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}
\RequirePackage{ifthen}
% Needed to use a toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change line spacing in specific environment
\RequirePackage[nodisplayskipstretch]{setspace}
% Needed to manage fonts
\RequirePackage[quiet]{fontspec}
% To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
% Needed to manage math fonts
\RequirePackage{unicode-math}
% Needed to use icons from font-awesome
% (https://github.com/posquit0/latex-fontawesome)
\RequirePackage{fontawesome5}
\RequirePackage[default,opentype]{sourcesanspro}
% Needed for the photo ID
\RequirePackage[skins]{tcolorbox}
% Needed to deal a paragraphs
\RequirePackage{parskip}
% Needed to deal hyperlink
\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}

% Allowing cells spanning multiple columns
\RequirePackage{multirow}
% Foreach to build tables
\RequirePackage{etoolbox}
% Alternative way for fixed length tables
\RequirePackage{tabularx}
% To draw boxes around skills
\RequirePackage{tcolorbox}
% Textblocks (absolute positioning of text)
\RequirePackage[overlay]{textpos}  % ,showboxes
% Lengths arithmetics
\RequirePackage{calc}
% Save positions on first compilation pass
\RequirePackage{zref-savepos}
% Tikz to do fancy figures (timeline)
\RequirePackage{tikz}
% Enable arithmetic with dimensions in tikz
\usetikzlibrary{calc}
% Enable positioning relative to .. in tikz
\usetikzlibrary{positioning}

% Use multiple bibliographies and citations
\RequirePackage[backend=biber,style=authortitle,maxbibnames=9,maxcitenames=4,sorting=ydnt,dashed=false]{biblatex}

% Define custom bibliography style to minimize output
\AtEveryBibitem{%
  \clearfield{doi} % Remove DOI
  \clearfield{url} % Remove URL
  \clearfield{isbn} % Remove ISBN
  \clearfield{issn} % Remove ISSN
  \clearfield{eprint} % Remove eprint
  \clearfield{note} % Remove note
  \clearlist{publisher} % Remove publisher
  \clearlist{location} % Remove location
  \clearfield{month} % Remove month
  \clearfield{language} % Remove language
  \clearfield{pages} % Remove pages
  \clearlist{language} % Remove pages
  \clearfield{volume} % Remove pages
  \clearfield{number} % Remove pages
}

% Configurable lengths (and their defaults) used in this class
% ----------------------------------------------------------

% Technical Detail
% - - - - - - - - - - - - - - - - - - -
% For vertical lengths, we can use a \newcommand{\<name>} as it's either used
% inside a \vspace{\<name>} or as an argument for parskip \\[\<name>]
%
% For horizontal lengths, we use a \newlength and \setlength as it gives us
% lengths that can be manipulated arithmically
% (e.g. 1\textwidth - 2\iconswidth)

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

% Header
% --------------------------------------
% Before header
\newcommand{\headerbeforeskip}{4mm}

% In between name & position
\newcommand{\headerinterskip}{4mm}

% After header
\newcommand{\headerafterskip}{4mm}

% Width for the photo
\newlength{\headerphotowidth}

% Summary
% --------------------------------------
\newcommand{\summaryafterskip}{3mm}

% Sections & Entries
% --------------------------------------
% Between section title and content
\newcommand{\sectioninterskip}{1.5mm}

% After the end of the whole section's content
\newcommand{\sectionafterskip}{0mm}

% Sidebar & Timeline
% --------------------------------------
% Create a length for the side margins (required for tikz absolute positioning)
\newlength{\sidemargin}

% Width of the left column
\newlength{\leftcolumnwidth}

% Margin between the left column and the start of the timeline
\newlength{\leftcolumnrightmargin}

% Margin on the side of the timeline (left & right)
\newlength{\timelinemargin}

% Width dedicated to date & location for cv entries
% TODO: not used right now, might be needed for resumes with long job title or
% companies
\newlength{\datelocationwidth}
\setlength{\datelocationwidth}{3cm}


% Icons (contacts & hobbies)
% --------------------------------------
\newlength{\iconswidth}  % Not used if you use \tabularx
\setlength{\iconswidth}{10.7pt}

% Debug commands
% --------------------------------------
% Create a boolean to enable/disable debug mode
\newbool{debugmode}
\setbool{debugmode}{false}

% Create commands for conditional code depending on debug mode
\newcommand{\debug}[2]{\ifbool{debugmode}{#1}{#2}}

\newenvironment{debugframe}{
    \debug{\begin{mdframed}}{}%
}{
    \debug{\end{mdframed}}{}%
}

\newcommand{\setupdebug}{\debug{
    % Needed for debugging base layout (margins, footer, ...)
    \RequirePackage{showframe}
    % Needed for debugging resume layout (header, columns, ...)
    \RequirePackage{mdframed}

    % Configuration for debug frames
    \mdfsetup{%
        % Border style
        linecolor=awesome,
        linewidth=1.2pt,
        % Margins
        innerleftmargin=0pt,
        innerrightmargin=0pt,
        innertopmargin=0pt,
        innerbottommargin=0pt,
    }
}}{}

%-------------------------------------------------------------------------------
% TODO: commands to clean up
%-------------------------------------------------------------------------------
% Others


% Layout
% --------------------------------------
% Configure page margins with geometry
\geometry{left=1.5cm, top=1.5cm, right=1.5cm, bottom=2cm, footskip=.5cm}

% Set offset to each header and footer
\fancyhfoffset{0em}

% Remove head rule
\renewcommand{\headrulewidth}{0pt}

% Clear all header & footer fields
\fancyhf{}

% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}



% Colors
% ----------------------------------------------------------

% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightgray}{HTML}{999999}

% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}

% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-darkblue}{HTML}{18678d}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}

% Icons colors
%\definecolor{iconcolor}{HTML}{505050}
\colorlet{iconcolor}{awesome-concrete}

% Boolean value to switch section color highlighting
\newbool{sectioncolorhighlight}
\setbool{sectioncolorhighlight}{true}

% Show sections tiles in `awesome` color if `highlightSections` is true
\def\@sectioncolor#1{%
    \ifbool{sectioncolorhighlight}{\color{awesome}#1}{\color{text}#1}%
}


% Fonts configuration
% ----------------------------------------------------------

% Set font for header (default is Roboto)
\newfontfamily\headerfont[
  Path = fonts/,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

\newfontfamily\headerfontlight[
  Path = fonts/,
  UprightFont=*-Thin,
  ItalicFont=*-ThinItalic,
  BoldFont=*-Medium,
  BoldItalicFont=*-MediumItalic,
]{Roboto}

% Provides additional symbols, browse at
% https://www.nerdfonts.com/cheat-sheet
\newfontfamily{\symbolsfont}[
  Path = fonts/,
  UprightFont=*-Regular,
  Extension=.ttf
]{SymbolsNerdFont}

% Aliases to contextualise fonts in differents parts of the resume
\newcommand*{\footerfont}{\sourcesanspro}
\newcommand*{\bodyfont}{\sourcesanspro}
\newcommand*{\bodyfontlight}{\sourcesansprolight}
\newcommand*{\icon}[1]{{\symbolsfont\color{iconcolor} #1}}

% Personal information inputs
% ----------------------------------------------------------
% Configure the different information that the writer needs to input in the
% main file (resume.tex)
%
% Defines commands that will store some input information into a variable that
% can later be used in elements (see the `elements` section)

% Define photo ID
% Usage: \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}
\newcommand{\photo}[2][circle,edge,left]{%
  \def\@photo{#2}
  \@for\tmp:=#1\do{%
    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
      {\let\@photoshape\tmp}{}%
    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
      {\let\@photoedge\tmp}{}%
    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
      {\let\@photoalign\tmp}{}%
  }%
}

% Set the default image configuration
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

% Headers Information
% ----------------------------

% Usage: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
% Usage: \firstname{<firstname>}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
% Usage: \lastname{<lastname>}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
% Usage: \familyname{<familyname>}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}\def\@familyname{\@lastname}
% Usage: \position{<position>}
\newcommand*{\position}[1]{\def\@position{#1}}

% Contacts Information
% ----------------------------

% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{#1}}
% Usage (optional): \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}
% Usage (optional): \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
% Usage (optional): \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}
% Usage (optional): \github{<github-nick>}
\newcommand*{\github}[1]{\def\@github{#1}}
% Usage (optional): \gitlab{<gitlab-nick>}
\newcommand*{\gitlab}[1]{\def\@gitlab{#1}}
% Usage (optional): \stackoverflow{<so userid>}{<so username>}
\newcommand*{\stackoverflow}[2]{\def\@stackoverflowid{#1}\def\@stackoverflowname{#2}}
% Usage (optional): \linkedin{<linked-in-user>}
\newcommand*{\linkedin}[1]{\def\@linkedinuser{#1}}
% Usage (optional): \twitter{<twitter handle>}
\newcommand*{\twitter}[1]{\def\@twitter{#1}}
% Usage (optional): \instagram{<instagram handle>}
\newcommand*{\instagram}[1]{\def\@instagram{#1}}
% Usage (optional): \orcid{orcid-id>}
\newcommand*{\orcid}[1]{\def\@orcid{#1}}

% Usage (optional): \extrainfo{<extra informations>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}
% Usage (optional): \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{#1}}

% Fonts & Styles
% ---------------------------------------------------------
% Configure how the different elements in the resume *look*

% Defines commands for the style of each named element of the resume, this
% includes:
% - font size    (e.g. 32pt)
% - font weight  (e.g. light)
% - colour

% Each command follows the pattern:
% > `\<element>style` e.g. `\headerpositionstyle`

% Header
% --------------------------------------
% First name & last name have different styles
\newcommand*{\headerfirstnamestyle}[1]
    {{\fontsize{32pt}{1em}\headerfontlight\color{graytext} #1}}
\newcommand*{\headerlastnamestyle}[1]
    {{\fontsize{32pt}{1em}\headerfont\bfseries\color{text} #1}}
% Job position is below the name
\newcommand*{\headerpositionstyle}[1]
    {{\fontsize{17pt}{1em}\bodyfont\scshape\color{awesome} #1}}
% Quote is an optional short sentence
\newcommand*{\headerquotestyle}[1]
    {{\fontsize{9pt}{1em}\bodyfont\itshape\color{darktext} #1}}

% Summary
% --------------------------------------
% Short paragraph about you
\newcommand*{\summarystyle}
    {\fontsize{10pt}{1em}\bodyfontlight\upshape\color{text}}

% Footer
% --------------------------------------
\newcommand*{\footerstyle}[1]
    {{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}

% Sidebar
% --------------------------------------
% Default style for most of the text & icons on the left column for
% consistency. Some more specific areas will be defined, but set as an
% alias to this by default.
\newcommand*{\sidebarstyle}[1]
    {{\fontsize{8pt}{1em}\bodyfontlight\color{text} #1}}
\newcommand*{\sidebariconstyle}[1]{{\fontsize{8pt}{1em}\bodyfont #1}}

% Contact
% --------------------------------------
\newcommand*{\contactstyle}[1]{\sidebarstyle{#1}}
\newcommand*{\contacticonstyle}[1]{\sidebariconstyle{#1}}


% Hobbies
% --------------------------------------
\newcommand*{\hobbiesstyle}[1]{\sidebarstyle{#1}}
\newcommand*{\hobbiesiconstyle}[1]{\sidebariconstyle{#1}}

% Skills
% --------------------------------------
\newcommand*{\skilltypestyle}[1]
    {{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\skillsetstyle}[1]
    {{\fontsize{7.5pt}{1em}\bodyfontlight\color{text} #1}}
\newcommand*{\languagestyle}[1]
    {{\fontsize{9.5pt}{1em}\bodyfontlight\color{text} #1}}

% Generic Section (Experience, Education, ...)
% --------------------------------------
\newcommand*{\sectionstyle}[1]
    {{\fontsize{16pt}{1em}\bodyfont\bfseries\scshape\@sectioncolor #1}}
\newcommand*{\subsectionstyle}[1]
    {{\fontsize{12pt}{1em}\bodyfont\scshape\textcolor{text}{#1}}}
\newcommand*{\paragraphstyle}
    {\fontsize{12pt}{1em}\bodyfontlight\upshape\color{text}}

% Entry elements
% --------------------------------------
\newcommand*{\entrytitlestyle}[1]
    {{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\entrypositionstyle}[1]
    {{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\entrydatestyle}[1]
    {{\fontsize{8pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\entrylocationstyle}[1]
    {{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\descriptionstyle}[1]
    {{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% Subentry elements
% --------------------------------------
\newcommand*{\subentrytitlestyle}[1]
    {{\fontsize{8pt}{1em}\bodyfont\mdseries\color{graytext} #1}}
\newcommand*{\subentrypositionstyle}[1]
    {{\fontsize{7pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\subentrydatestyle}[1]
    {{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\subentrylocationstyle}[1]
    {{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\subdescriptionstyle}[1]
    {{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% Bibliography
% --------------------------------------
\renewcommand*{\bibfont}{\descriptionstyle}


% Elements
% ---------------------------------------------------------
% Defines commands to include the different elements.
%
% Reminder of the overall layout of the resume (by default)
% ┌───────────────────────────────────────────────────────────┐
% │   ┌─────────┐                                             │
% │   │         │  ┌────────────────────────────────┐         │
% │   │ picture │  │          Name Surname          │         │
% │   │         │  └────────────────────────────────┘         │
% │   └─────────┘      job title - specialisation             │
% │   ┌───────────────────────────────────────────────────┐   │
% │   │ Summary                                           │   │
% │   └───────────────────────────────────────────────────┘   │
% │                                                           │
% │   Contact          ● Experience                           │
% │                    │                                      │
% │   ϟ     ~~~~~~~~   ○ Company                    Location  │
% │   ϟ       ~~~~~~   │ Job Title              start - stop  │
% │   ϟ     ~~~~~~~~   │ • ~~~~~~~~~~~~~                      │
% │   ϟ ~~~~ ϟ ~~~~    │  • ~~~~~~~~~                         │
% │                    │  • ~~~~~~~                           │
% │   Skills           │ • ~~~~~~~~~~~~~~                     │
% │                    │                                      │
% │   Group 1          ○ Company                    Location  │
% │   ▢▢▢▢ ▢▢▢▢ ▢▢▢▢   │ Job Title              start - stop  │
% │   Group 2          │ • ~~~~~~~~~~~~~                      │
% │   ▢▢▢▢ ▢▢▢▢ ▢▢▢▢   │  • ~~~~~~~~~                         │
% │                    │  • ~~~~~~~                           │
% │   Hobbies          │ • ~~~~~~~~~~~~~~                     │
% │   ϟ     ~~~~~~~~   │  • ~~~~~~~~                          │
% │   ϟ      ~~~~~~~   │  • ~~~~~~~~~~                        │
% │                    ● Education                            │
% │   Languages        │                                      │
% │   ϟ     ~~~~~~~~   ○ Degree Name                Location  │
% │   ϟ      ~~~~~~~   │ University             start - stop  │
% │                    │                                      │
% │                                                           │
% │                                                           │
% │                        footer                       date  │
% └───────────────────────────────────────────────────────────┘

% Utilities Commands
% --------------------------------------
% Align elements in tabular tables
\newcolumntype{L}[1]
    {>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]
    {>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]
    {>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Draw horizontal line with specific thickness
\def\vhrulefill#1
    {\leavevmode\leaders\hrule\@depth-4pt\@height4.9pt\hfill \kern\z@}

% Execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}


% Header & Picture
% --------------------------------------
% ┌───────────────────────────────────────────────────────────┐
% │   ┌─────────┐                                             │
% │   │         │  ┌────────────────────────────────┐         │
% │   │ picture │  │          Name Surname          │         │
% │   │         │  └────────────────────────────────┘         │
% │   └─────────┘      job title - specialisation             │
% │ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - │
% Provides a single command to create the header: \makecvheader

% Command for the separation between name & surname
\newcommand{\headernamedelim}{\space}

% Define a header for CV
% Usage: \makecvheader{<align-char>} (options: L | C | R)
\newcommand*{\makecvheader}[1][C]{%
    % Draw the photo (if defined)
    \newcommand*{\drawphoto}{%
        \ifthenelse{\isundefined{\@photo}}{}{%
            % Figure out the dimensions depending on edge type (circle / edge)
            \newlength{\photodim}
            \ifthenelse{\equal{\@photoshape}{circle}}%
                {\setlength{\photodim}{1.3cm}}%
                {\setlength{\photodim}{1.8cm}}%

            % Add a border for the `edge` shape
            \ifthenelse{\equal{\@photoedge}{edge}}%
                {\def\@photoborder{darkgray}}%
                {\def\@photoborder{none}}%

            % Draw the photo using tikz
            \begin{tikzpicture}%
                \node[
                    \@photoshape,
                    draw=\@photoborder,
                    line width=0.3mm,
                    inner sep=\photodim,
                    fill overzoom image=\@photo
                ] () {};
            \end{tikzpicture}

        }%
    }

    % Figure out the width for text vs. photo
    \newlength{\headertextwidth}
    \ifthenelse{\isundefined{\@photo}}{
        % No photo => force 0cm for photo
        \let\headerphotowidth\relax
        \newlength{\headerphotowidth}
        \setlength{\headerphotowidth}{0cm}
    }{%
        % Photo => default to ~ 25% for photo, 75% for text
        \ifthenelse{\isundefined{\headerphotowidth}}{%
            \setlength{\headerphotowidth}{0.24\textwidth}
        }{}
    }%
    \setlength{\headertextwidth}{\textwidth - \headerphotowidth}

    % Create minipages to show the photo & text side-by-side
    \begin{debugframe}
    \vspace{\headerbeforeskip}
    % Minipage for left-side photo
    \ifthenelse{\equal{\@photoalign}{left}}{
        \begin{minipage}[c]{\headerphotowidth}%
            \begin{debugframe}
            \raggedright\drawphoto%
            \end{debugframe}
        \end{minipage}%
    }{}%
    % Minipage for text
    \begin{minipage}[c]{\headertextwidth}
        \begin{debugframe}
        % Handle text alignment (options: L | C | R)
        \ifthenelse{\equal{#1}{L}}{
            % Argument #1 <align-char> is 'L'
            \begin{flushleft}
        }{\ifthenelse{\equal{#1}{R}}{
            % Argument #1 <align-char> is 'R'
            \begin{flushright}
        }{
            % Argument #1 <align-char> is anything else (includes empty)
            \begin{center}
        }}

        % Text with 'firstname <sep> lastname'
        \headerfirstnamestyle{\@firstname}%
        \headerlastnamestyle{{}\space\@lastname}%
        \\[\headerinterskip]

        % Handle text alignment (options: L | C | R)
        \ifthenelse{\equal{#1}{L}}{
            % Argument #1 <align-char> is 'L'
            \raggedright
        }{\ifthenelse{\equal{#1}{R}}{
            % Argument #1 <align-char> is 'R'
            \raggedleft
        }{
            % Argument #1 <align-char> is anything else (includes empty)
            \centering
        }}

        % Position text (if defined)
        \ifthenelse{\isundefined{\@position}}{}{
            % Position => inter-skip, position, after skip
            \headerpositionstyle{\@position}
        }

        % Handle text alignment (options: L | C | R)
        \ifthenelse{\equal{#1}{L}}{
            % Argument #1 <align-char> is 'L'
            \end{flushleft}
        }{\ifthenelse{\equal{#1}{R}}{
            % Argument #1 <align-char> is 'R'
            \end{flushright}
        }{
            % Argument #1 <align-char> is anything else (includes empty)
            \end{center}
        }}
        \end{debugframe}
    \end{minipage}%
    % Minipage for right-side photo
    \ifthenelse{\equal{\@photoalign}{right}}{%
        \begin{minipage}[c]{\headerphotowidth}%
            \begin{debugframe}
            \raggedleft\drawphoto%
            \end{debugframe}
        \end{minipage}
    }{}%
    \vspace{\headerafterskip}
    \end{debugframe}
}

% Summary
% --------------------------------------
% The summary is just a paragraph in between the header and the main body of
% the resume (sidebar on the left and timeline of events on the right)
% │ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - │
% │   ┌───────────────────────────────────────────────────┐   │
% │   │ Summary                                           │   │
% │   └───────────────────────────────────────────────────┘   │
% │ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - │
\newenvironment{cvsummary}{%
    \setlength{\parskip}{0pt}
    \summarystyle
}{%
    \vspace{\summaryafterskip}
}


% Footer
% --------------------------------------
% Provides the footer as a single command with 3 elements:
% <left>, <center>, <right>
% │ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - │
% │                        footer                       date  │
% └───────────────────────────────────────────────────────────┘

% Define a footer for every page of the resume
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#3}}
}

% Sidebar vs. Body
% --------------------------------------
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │   Contact          ● Experience                           │
% │                    │                                      │
% │   ϟ     ~~~~~~~~   ○ Job Title                  Location  │
% │   ϟ       ~~~~~~   │ Company                start - stop  │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
%        sidebar                       body


% Sidebar Table
% --------------------------------------
% Table meant to be used on the left column of the layout, with the left
% column containing icons (or short text) and the right column text that fit in
% one line (multi-line doesn't look very good).
%
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │   Contact          ●                                      │
% │                    │                                      │
% │   ϟ     ~~~~~~~~   ○                                      │
% │   ϟ       ~~~~~~   │                                      │
% │   ϟ     ~~~~~~~~   │                                      │
% │   ϟ ~~~~ ϟ ~~~~~   │                                      │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% @TODO: currently, the code using `tabularx`, which is fairly elegant, does not
% work inside an `\newenvironment`. I don't have time to troubleshoort that, so
% the tables code will be in the main files for now.
%
% Below is an iteration using `tabular*` which does work for icons, but requires
% fine-tuning of the dimension of the left column (containing the icons).
\newenvironment{iconstable}{
    % Reduce horizontal space around cells content
    \setlength{\tabcolsep}{2pt}
    \debug{% In debug mode, add vertical separator between columns
        \begin{tabular*}{\leftcolumnwidth}
            {|c|R{\leftcolumnwidth - 4\tabcolsep - \iconswidth}|}
    }{%
        \begin{tabular*}{\leftcolumnwidth}
            {cR{\leftcolumnwidth - 4\tabcolsep - \iconswidth}}
    }%
    \debug{\hline}{}
}{
    \debug{\hline}{}
    \end{tabular*}
}


% Contacts items
% --------------------------------------
% The contacts table is versatile, as many elements can be integrated or not
% depending on the author.
%
% We define below elements and their corresponding icons. The pattern is the
% following:
% - \c<element> e.g. \caddress -> \contactstyle{\@<element>}
% - \c<element>icon e.g. \caddressicon -> \contacticonstyle{\@<element>}
%
% When possible, a clickable link to the element is provided with
% \href{<link>}{\@<element>} e.g. google maps for the address.

% Elements text & icons
% - - - - - - - - - - - - - - - - - - -
% Address
\def\caddress{\contactstyle{%
    \href{https://maps.google.com/?\@address}{\@address}}}
\def\caddressicon{\contacticonstyle{% alternative icon: `\icon{}`
    \href{https://maps.google.com/?\@address}{\icon{\faMapMarked*}}}}

% Mobile
\def\cmobile{\contactstyle{\@mobile}}
\def\cmobileicon{\contacticonstyle{\icon{\faMobile}}}

% Github
\def\cgituser{\contactstyle{%
    \href{https://github.com/\@github}{\@github}}}
\def\cgiticon{\contacticonstyle{%
    \href{https://github.com/\@github}{\icon{\faGithubSquare}}}}
\def\cgitproject#1{\contacticonstyle{%
    \href{https://github.com/\@github/#1}{\scalebox{0.8}{\icon{\faGithub}}}}}

% Linkedin
\def\clinkedinuser{\contactstyle{%
    \href{https://www.linkedin.com/in/\@linkedinuser}{\@linkedinuser}}}
\def\clinkedinicon{\contacticonstyle{%
    \href{https://www.linkedin.com/in/\@linkedinuser}{\icon{\faLinkedin}}}}

% Email
\def\cemail{\contactstyle{\href{mailto:\@email}{\@email}}}
\def\cemailicon{\contacticonstyle{\href{mailto:\@email}{\icon{\faEnvelope}}}}

% Orcid
\def\corciduser{\contactstyle{\href{https://orcid.org/\@orcid}{\@orcid}}}
\def\corcidicon{\contacticonstyle{%
    \href{https://orcid.org/\@orcid}{\icon{\faOrcid}}}}

% In-place link (any website, publication, ...)
\def\cpaperlink#1{\contacticonstyle{%
    \href{#1}{\scalebox{0.8}{\icon{\faExternalLink*}}}}}

% Skills
% --------------------------------------
% This section (on the left side) provides an overview of keywords related to
% your industry for a first scan of compatibility of your profile with the
% position.
%
% Ideally, the list of skills should be fairly short as you should tailor it to
% the job you're targeting.
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │   Skills           │                                      │
% │                    │                                      │
% │   Group 1          ○                                      │
% │   ▢▢▢▢ ▢▢▢▢ ▢▢▢▢   │                                      │
% │   ▢▢▢▢ ▢▢▢▢        │                                      │
% │   Group 2          │                                      │
% │   ▢▢▢▢ ▢▢▢▢ ▢▢▢▢   │                                      │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │

% Skills entry
% - - - - - - - - - - - - - - - - - - -
% Starts a new entry for skills (group of related keyword badges).
% Usage: \skillcategory{<title>}
\newcommand*{\skillcategory}[1]{\skilltypestyle{#1}}

% Skills table
% - - - - - - - - - - - - - - - - - - -
% Implement the skill badge using tikz
\newcommand*{\skilltikz}[2]{
    \begin{tikzpicture}[
        x=0.2cm,
        y=0.23cm,
        color=lighttext!50!graytext,
        skill/.style={text width=1.5cm, align=left},
        icon/.style={text width=0.5cm, align=center},
    ]
        \def\swidth{2.5}
        \def\shift{0.4}

        \node[skill] (S) at (0,0) {\skillsetstyle{#1}};
        %\node[icon] (I) at (1.9,0) {\skillsetstyle{#2}};
        \draw[] ({- 4 - \shift},1) -- ({\swidth + \shift},1) -- ({\swidth + \shift},-1) -- ({-4 - \shift},-1) -- cycle;
        %\draw[line width=0.4pt, densely dashed] (\swidth - 1.5,1) -- (\swidth - 1.5,-1);
    \end{tikzpicture}
}

% Implement the skill badge with tcolorbox
\newtcolorbox{skillbadge}{
    % Color of the box and content
    colframe=lighttext,
    colback=white,
    % TODO: Arbitrary height and width, could be configurable
    height=11pt,
    width=1.47cm,
    boxrule=0.4pt,
    % Padding
    top=-0.8pt,  % Visually center vertically
    bottom=0pt,
    left=-1pt,
    right=-1pt,
    % Other settings
    tcbox raise base,
    halign=center,
    nobeforeafter,
    on line,
}

\newcommand*{\skill}[1]{
    % Use the tcolorbox implementation
    \begin{skillbadge}\skillsetstyle{#1}\end{skillbadge}
}

\newenvironment{skillstable}{
    % TODO: unify lengths
    \vspace{-0.3mm}
}{
    \vspace{-1.0mm}
}

% Entries Titles
% --------------------------------------
% Main nodes titles (section) and minor nodes titles (entries)
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │                 => ● Experience                           │
% │                    │                                      │
% │                 => ○ Job Title                   Location │
% │                    │ Company                 start - stop │
% │                    │ • ~~~~~~~~~~~~~                      │
% │                    │  • ~~~~~~~~~                         │
% │                    │  • ~~~~~~~                           │
% │                    │ • ~~~~~~~~~~~~~~                     │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │

% CV Section (Experience, Education, ...)
% - - - - - - - - - - - - - - - - - - -
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{%
    \sectionstyle{#1}
    \phantomsection
    \startsection
}

% Define a subsection for CV
% Usage: \cvsubsection{<subsection-title>}
\newcommand{\cvsubsection}[1]{%
    % TODO: troubleshoot when used
    \vspace{\sectioninterskip}
    \vspace{-3mm}
    \subsectionstyle{#1}
    \phantomsection
}


% CV Entry
% - - - - - - - - - - - - - - - - - - -
% Main entry to show an experience or degree and an associated date/duration
% and location.
% There are 2 separate ways to use this command.
%
% (1) Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
% • Full experience description (what, where [city], where [company], when)
%
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │                 => ○ Job Title                   Location │
% │                 => │ Company                 start - stop │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
%
%
% (2) Usage: \cventry{<position>}{}{}{<date>}{<description>}
% • Shorter experience description: what, when
% • Good for personal projects for instance
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │                 => ○ Job Title               start - stop │
% │                    │ • ~~~~~~~~~~                         │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
%
% Note that 'position' and 'title' can be interchanged depending on what you
% want to highlight in your professional experience
%
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
\newcommand*{\cventry}[5]{%
    % Configure an almost invisible table environment
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    % Ensure there are no vertical paragraph skips
    \setlength{\parskip}{0pt}
    % Handle counter and positions for entry start
    \startentry
    \begin{tabular*}{\textwidth}{l r}
        \ifempty{#2#3}{%
            % Shorter usage (2)
            \entrypositionstyle{#1} & \entrydatestyle{#4} \\
        }{%
            % Complete usage (1)
            \entrytitlestyle{#2} & \entrylocationstyle{#3} \\
            \entrypositionstyle{#1} & \entrydatestyle{#4} \\
        }%
        % In all usages, the description is handled the same way
        \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}
    \end{tabular*}%
}

% CV Subentry
% - - - - - - - - - - - - - - - - - - -

% TODO: use in one example & clean up
% Usage: \cvsubentry{<position>}{<title>}{<date>}{<description>}
\newcommand*{\cvsubentry}[4]{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \setlength\leftskip{0.2cm}
    \subentrytitlestyle{#2} & \ifthenelse{\equal{#1}{}}
      {\subentrydatestyle{#3}}{}
    \ifthenelse{\equal{#1}{}}
      {}
      {\subentrypositionstyle{#1} & \subentrydatestyle{#3} \\}
    \ifthenelse{\equal{#4}{}}
      {}
      {\multicolumn{2}{L{17.0cm}}{\subdescriptionstyle{#4}} \\}
  \end{tabular*}
}


% Entries Content
% --------------------------------------
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │
% │                    ● Experience                           │
% │                    │                                      │
% │                    ○ Job Title                   Location │
% │                    │ Company                 start - stop │
% │                 => │ • ~~~~~~~~~~~~~                      │
% │                 => │  • ~~~~~~~~~                         │
% │                 => │  • ~~~~~~~                           │
% │                 => │ • ~~~~~~~~~~~~~~                     │
% │ - - - - - - - - - -+- - - - - - - - - - - - - - - - - - - │

% Keywords
% - - - - - - - - - - - - - - - - - - -
% Highlight keywords that relate to your skills (but within the context of your
% experiences)
\newcommand*{\keyword}[1]{\keywordstyle{#1}}


% Paragraph
% - - - - - - - - - - - - - - - - - - -
\newenvironment{cvparagraph}{%
    \vspace{\sectioninterskip}
    \vspace{-3mm}
    \paragraphstyle
}{%
    \par
    \vspace{2mm}
}


% Entries
% - - - - - - - - - - - - - - - - - - -
% Environment spanning the whole section's content
\newenvironment{cventries}[1][]{%
    % Make sure that you can set a title/separator for the current entry-list
    \raggedright\entrytitlestyle{#1}
    \vspace{\sectioninterskip}
    \begin{center}
}{%
    % Save the position of the end of section as 'A1-end' in the aux file
    \end{center}
    \stopsection
    \vspace{\sectionafterskip}
}

% Environment for list items
% - - - - - - - - - - - - - - - - - - -
\newenvironment{cvitems}{%
    \vspace{-4.0mm}
    \begin{justify}
        \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
            \setlength{\parskip}{0pt}
            \renewcommand{\labelitemi}{\bullet}
            \renewcommand{\labelitemii}{$\circ$}
}{%
        \end{itemize}
    \end{justify}
    \vspace{-4.0mm}
}

% Nested list items (in previous env)
% - - - - - - - - - - - - - - - - - - -
\newenvironment{cvitemsnested}{
    \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
}{
    \end{itemize}
}


% Timeline & Dual-Column Layout
% ---------------------------------------------------------
% This is the main element brought by this one-page resume template.
%      ┌───────────────────────────────────────────────────────────────┐
%      │            ┌────────────────────────────────┐                 │
%      │            │          Name Surname          │                 │
%      │            └────────────────────────────────┘                 │
%      │                job title - specialisation                     │
%      │                                                               │
%      │    ┌────────────────────────────────────────────────────┐     │
%      │    │ Summary / Quote                                    │     │
%      │    └────────────────────────────────────────────────────┘     │
%      │  ╔════════════════╔═══╗════════════════════════════════════╗  │
%      │  ║ Contact        ║ ● ║ Experience                         ║  │
%      │  ║                ║ │ ║                                    ║  │
%      │  ║ ϟ     ~~~~~~~~ ║ ○ ║ Job Title                 Location ║  │
%      │  ║ ϟ       ~~~~~~ ║ │ ║ Company               start - stop ║  │
%      │  ║ ϟ     ~~~~~~~~ ║ │ ║ • ~~~~~~~~~~~~~                    ║  │
%      │  ║ ϟ ~~~~ ϟ ~~~~  ║ │ ║  • ~~~~~~~~~                       ║  │
%      │  ║                ║ │ ║  • ~~~~~~~                         ║  │
%      │  ║ Skills         ║ │ ║ • ~~~~~~~~~~~~~~                   ║  │
%      │  ║                ║ │ ║                                    ║  │
%      │  ║ Group 1        ║ ○ ║ Job Title                 Location ║  │
%      │  ║ ▢▢▢▢ ▢▢▢▢ ▢▢▢▢ ║ │ ║ Company               start - stop ║  │
%      │  ║ Group 2        ║ │ ║ • ~~~~~~~~~~~~~                    ║  │
%      │  ║ ▢▢▢▢ ▢▢▢▢ ▢▢▢▢ ║ │ ║  • ~~~~~~~~~                       ║  │
%      │  ║                ║ │ ║  • ~~~~~~~                         ║  │
%      │  ║ Hobbies        ║ │ ║ • ~~~~~~~~~~~~~~                   ║  │
%      │  ║ ϟ     ~~~~~~~~ ║ │ ║  • ~~~~~~~~                        ║  │
%      │  ║ ϟ      ~~~~~~~ ║ │ ║  • ~~~~~~~~~~                      ║  │
%      │  ║                ║ ● ║ Education                          ║  │
%      │  ║ Languages      ║ │ ║                                    ║  │
%      │  ║ ϟ     ~~~~~~~~ ║ ○ ║ Degree Name               Location ║  │
%      │  ║ ϟ      ~~~~~~~ ║ │ ║ University            start - stop ║  │
%      │  ║                ║ │ ║                                    ║  │
%      │  ╚════════════════╚═══╝════════════════════════════════════╝  │
%      │               >> TIMELINE <<                                  │
%      │                         footer                        date    │
%      └───────────────────────────────────────────────────────────────┘

% This counter counts major nodes (sections)
\newcounter{sections}
% This counter counts minor nodes (entries). Resets when sections increments.
\newcounter{entries}[sections]

% If you want more ganularity in the nodes (e.g. to highlight multiple position
% in the same company, ...) you can create a counter that resets when the
% previous one increments.

% Dealing with tikz coordinates
% --------------------------------------
% Set of command to go from distances (pt. & others) to a position that tikz
% can work with

% Converts the values saved by `zref-savepos` to a more convenient unit (pt.)
% Important: if the label is not defined, the value is 0
\newcommand*{\getposy}[1]{\the\dimexpr\zposy{#1}sp\relax}
\newcommand*{\getposx}[1]{\the\dimexpr\zposx{#1}sp\relax}

% Command for the x-shift of labels. This decides the horizontal position of
% the timeline.
\newcommand{\tikzposxshift}{%
    \evensidemargin + 1in  % https://tex.stackexchange.com/a/101861
    + \leftcolumnwidth + \leftcolumnrightmargin + \timelinemargin%
}

% Coordinates per type of node
% --------------------------------------
% Define a command for each type of node as the (x,y) coordinates might require
% adjustments depending on the type of node (e.g. higher line, ...)

% Usage: \tikzpossection{<section-label>} e.g. \tikzpossection{A0}
\newcommand{\tikzpossection}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} + 5pt]current page.south west)
}
% Usage: \tikzposentry{<entry-label>} e.g. \tikzposentry{A1}
\newcommand{\tikzposentry}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} - 7pt]current page.south west)
}
% Usage: \tikzposend{<end-label>} e.g. \tikzposend{A4-end}
\newcommand{\tikzposend}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} - 0pt]current page.south west)
}

% Counters transitions
% --------------------------------------
% Define some commands to handle the counter transition logic, in order to have
% all the logic related to counters/positions defined here
\newcommand{\startsection}{%
    % Increase the sections counter (A3 -> B0)
    \stepcounter{sections}%
    % Save the position of the section as 'B0' in the aux file
    \zsavepos{\Alph{sections}\arabic{entries}}%
}
\newcommand{\startentry}{%
    % Increase the entries counter (A0 -> A1)
    \stepcounter{entries}%
    % Save the position of the section as 'A0' in the aux file
    \zsavepos{\Alph{sections}\arabic{entries}}%
}
\newcommand{\stopsection}{%
    % Save the current position as 'A3-end' in the aux file
    \zsavepos{\Alph{sections}\arabic{entries}-end}%
}

% Drawing the timeline
% --------------------------------------
% The timeline works by saving positions (A, A1, ...) in the aux file.
% On a second pass, we can then draw the timeline in the middle of the two
% columns (absolute positioning) using the positions we gathered.
%
% There are a couple corner cases to the logic, but in general we want to
% declare the nodes {A, A1, ..., A5-end} then draw the lines from one to
% the next.
%
%             ╔═══╗══════════════════════════════════╗
%        (A0) ║ ● ║ Work Experience                  ║
%             ║ │ ║                                  ║
%        (A1) ║ ○ ║ Job title               Location ║
%             ║ │ ║ Company                     Date ║
%             ║ │ ║ • ~~~~~~~~~~~~~~                 ║
%    (A1-end) ║ │ ║ • ~~~~~~~~~~~~~~~~~~~~           ║
%             ║ │ ║                                  ║
%        (A2) ║ ○ ║ Job title               Location ║
%             ║ │ ║ Company                     Date ║
%             ║ │ ║ • ~~~~~~~~~~~~~~~~               ║
%    (A2-end) ║ │ ║ • ~~~~~~~~~                      ║
%             ║   ║                                  ║
%        (B0) ║ ● ║ Education                        ║
%             ║ │ ║                                  ║
%        (B1) ║ ○ ║ Degree                  Location ║
%             ║ │ ║ University                  Date ║
%    (B1-end) ║ │ ║ • ~~~~~~~~~                      ║
%             ║ │ ║                                  ║
%        (B2) ║ ○ ║ Degree                  Location ║
%             ║ │ ║ University                  Date ║
%    (B2-end) ║ │ ║ • ~~~~~~~~~~~                    ║
%             ║ │ ║                                  ║
%        (B3) ║ ○ ║ Degree                  Location ║
%             ║ │ ║ University                  Date ║
%             ║ │ ║ • ~~~~~~~~~~                     ║
%    (B3-end) ║ │ ║ • ~~~~~~~~~                      ║
%             ╚═══╝══════════════════════════════════╝
%
% When looking at this diagram, we realise that we want to define and draw:
% (A0) -- (A1) -- (A2) -- (A2-end)
% (B0) -- (B1) -- (B2) -- (B3) -- (B3-end)
%
% Note that in the regular layout, all sections will be counted, but some of
% those will be on the left-side of the layout.
% This means that we need to start at a given section (e.g. C).
%
% When dealing with multiple pages, you will also need to re-draw the timeline
% in a new page, starting to the new section. You can decide to draw the
% timeline on the right or left side of the page (vs. the middle in default
% layout) by playing with the lengths used in `\tikzposxshift`, namely
% `\sidebarwidth` and `\timelinemargin`

% Usage: \timeline{<letter>} e.g. \timeline{B}
% Where <letter> is the first section on the right side
\newcommand{\timeline}[1]{
    % First argument `#1` is the first section on the right side
    \begin{tikzpicture}[
        remember picture,
        overlay,
        % Colour for the elements drawn
        color=darktext,
        % Style for sections node (currently: filled black circle)
        section/.style={circle, fill, inner sep=0pt, minimum size=7pt},
        % Style for entries node (currently: empty black circle, smaller)
        entry/.style={circle, draw, inner sep=0pt, minimum size=5pt},
        % Add here any style for further subdivision (e.g. internal mobility)
    ]
        % We don't know how many sections exist: iterate from the first letter
        % to some upper-bound (e.g. +10).
        \foreach \s[count=\i from 0] in {#1}{
            % From here on, `\s` will have the value of the current section's
            % letter (A, B, ...)

            % If the section exists, create a node `S0`
            \ifnum \zposy{\s0}>0
                \node[section] (\s0) at \tikzpossection{\s0} {};
            \fi

            % We don't know how many entries exist
            % Iterate from the first index to some upper-bound (e.g. +10)
            \foreach \e[remember=\e as \laste (initially 0)] in {1,...,25}{
                % If the position is non-null (exists), we create a node and
                % draw from last node.
                \ifnum \zposy{\s\e}>0
                    \node[entry]  (\s\e) at \tikzposentry{\s\e} {};
                    \draw (\s\laste) -- (\s\e);
                \fi

                % We need to remember the previous node to detect if we're at
                % the end of a given section (e.g. \s = A, \laste = 6, \e = 7)
                \ifnum \zposy{\s\laste}>0  % A6 exists
                    \ifnum \zposy{\s\e}=0  % A7 doesn't
                        % We declare (A6-end) then draw (A6) -- (A6-end)
                        \node[] (final\s) at \tikzposend{\s\laste-end} {};
                        \draw (\s\laste) -- (final\s);
                    \fi
                \fi
            }
        }
    \end{tikzpicture}
    % TODO: creating the timeline inserts vertical space wherever we call the
    % code - this hack is here to compensate that space.
    \vspace{-4mm}
}
