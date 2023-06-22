%% Start of file `resume.cls'.
% Resume Class File
%
% Notes:
% 1) This class file defines the structure and layout of the template file (cv.tex, resume.tex).
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%

%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{resume}[Custom Resume]
\NeedsTeXFormat{LaTeX2e}


%-------------------------------------------------------------------------------
%                Class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% Options for draft or final
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}


%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------
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
\RequirePackage{xcolor}
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


%-------------------------------------------------------------------------------
%                Configuration for directory locations
%-------------------------------------------------------------------------------
% Configure a directory location for fonts(default: 'fonts/')
\newcommand*{\fontdir}[1][fonts/]{\def\@fontdir{#1}}
\fontdir


%-------------------------------------------------------------------------------
%                Configuration for layout
%-------------------------------------------------------------------------------
%% Page Layout
% Configure page margins with geometry
\newlength{\sidemargin}
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm}

%% Header & Footer
% Set offset to each header and footer
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
% Clear all header & footer fields
\fancyhf{}
% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}


%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
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

% Boolean value to switch section color highlighting
\newbool{acvSectionColorHighlight}
\setbool{acvSectionColorHighlight}{true}

% Awesome section color
\def\@sectioncolor#1#2#3{%
  \ifbool{acvSectionColorHighlight}{{\color{awesome}#1#2#3}}{#1#2#3}%
}


%-------------------------------------------------------------------------------
%                Configuration for fonts
%-------------------------------------------------------------------------------
% Set font for header (default is Roboto)
\newfontfamily\headerfont[
  Path=\@fontdir,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

\newfontfamily\headerfontlight[
  Path=\@fontdir,
  UprightFont=*-Thin,
  ItalicFont=*-ThinItalic,
  BoldFont=*-Medium,
  BoldItalicFont=*-MediumItalic,
]{Roboto}

\newfontfamily{\symbolsfont}[
  Path=\@fontdir,
  UprightFont=*-Regular,
  Extension=.ttf
]{SymbolsNerdFont}

\newcommand*{\footerfont}{\sourcesanspro}
\newcommand*{\bodyfont}{\sourcesanspro}
\newcommand*{\bodyfontlight}{\sourcesansprolight}

\newcommand*{\icon}[1]{{\symbolsfont #1}}

%-------------------------------------------------------------------------------
%                Configuration for styles
%-------------------------------------------------------------------------------
% Configure styles for each CV elements

% For elements of the sidebar
\newcommand*{\sidebarstyle}[1]{{\fontsize{9.5pt}{1em}\bodyfontlight\color{text} #1}}
\newcommand*{\sidebariconstyle}[1]{{\fontsize{8pt}{1em}\bodyfont\color{text} #1}}


% For fundamental structures
\newcommand*{\headerfirstnamestyle}[1]{{\fontsize{32pt}{1em}\headerfontlight\color{graytext} #1}}
\newcommand*{\headerlastnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\bfseries\color{text} #1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{17pt}{1em}\bodyfont\scshape\color{awesome} #1}}
%\newcommand*{\headeraddressstyle}[1]{{\fontsize{8pt}{1em}\headerfont\itshape\color{lighttext} #1}}
%\newcommand*{\headersocialstyle}[1]{{\fontsize{6.8pt}{1em}\headerfont\color{text} #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\itshape\color{darktext} #1}}
\newcommand*{\footerstyle}[1]{{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}
\newcommand*{\sectionstyle}[1]{{\fontsize{16pt}{1em}\bodyfont\bfseries\scshape\color{text}\@sectioncolor #1}}
\newcommand*{\subsectionstyle}[1]{{\fontsize{12pt}{1em}\bodyfont\scshape\textcolor{text}{#1}}}
\newcommand*{\paragraphstyle}{\fontsize{12pt}{1em}\bodyfontlight\upshape\color{text}}

\newcommand*{\headersocialstyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\color{text} #1}}
\newcommand*{\headeraddressstyle}[1]{\headersocialstyle{#1}}
\newcommand*{\headericonstyle}[1]{\sidebariconstyle{#1}}

% For elements of entry
\newcommand*{\entrytitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{8pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% For elements of subentry
\newcommand*{\subentrytitlestyle}[1]{{\fontsize{8pt}{1em}\bodyfont\mdseries\color{graytext} #1}}
\newcommand*{\subentrypositionstyle}[1]{{\fontsize{7pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\subentrydatestyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\subentrylocationstyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\subdescriptionstyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% For elements of hobbies
%\newcommand*{\hobbyiconstyle}[1]{{\fontsize{11.5pt}{1em}\bodyfont\color{text} #1}}
%\newcommand*{\hobbiesstyle}[1]{{\fontsize{9.5pt}{1em}\bodyfont\color{text} #1}}
\newcommand*{\hobbyiconstyle}[1]{\headericonstyle{#1}}
\newcommand*{\hobbiesstyle}[1]{\headersocialstyle{#1}}

% For elements of skill
\newcommand*{\skilltypestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{7.5pt}{1em}\bodyfontlight\color{text} #1}}
\newcommand*{\languagestyle}[1]{\sidebarstyle{#1}}

%\newcommand*{\skillsetstyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\color{text} #1}}


%-------------------------------------------------------------------------------
%                Commands for personal information
%-------------------------------------------------------------------------------
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
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

% Define writer's name
% Usage: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
% Usage: \firstname{<firstname>}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
% Usage: \lastname{<lastname>}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
% Usage: \familyname{<familyname>}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}
% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{#1}}
% Usage: \position{<position>}
\newcommand*{\position}[1]{\def\@position{#1}}
% Usage (optional): \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
% Usage (optional): \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}
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
% Usage (optional): \extrainfo{<extra informations>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}
% Usage (optional): \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{#1}}


%-------------------------------------------------------------------------------
%                Commands for extra
%-------------------------------------------------------------------------------
%% Define helper macros a user can change easily
% Header
\newcommand{\acvHeaderNameDelim}{\space}
\newcommand{\acvHeaderAfterNameSkip}{4mm}
\newcommand{\acvHeaderAfterPositionSkip}{4.5mm}
\newcommand{\acvHeaderAfterAddressSkip}{-.5mm}
\newcommand{\acvHeaderIconSep}{\space}
\newcommand{\headerSep}{\quad\textbar\quad}
\newcommand{\acvHeaderAfterSocialSkip}{3mm}
\newcommand{\acvHeaderAfterQuoteSkip}{0mm}

% Others
\newcommand{\acvEntryTopSkip}{-2.5mm}
\newcommand{\acvSectionTopSkip}{0pt}
\newcommand{\acvSectionContentTopSkip}{1.5mm}


%-------------------------------------------------------------------------------
%                Commands for utilities
%-------------------------------------------------------------------------------
% Use to align an element of tabular table
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Use to draw horizontal line with specific thickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@depth-4pt\@height4.9pt\hfill \kern\z@}
%\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}


%-------------------------------------------------------------------------------
%               Header
%-------------------------------------------------------------------------------
% Define a header for CV
% Usage: \makecvheader
\newcommand*{\makecvheader}[1][C]{%
  \newcommand*{\drawphoto}{%
    \ifthenelse{\isundefined{\@photo}}{}{%
      \newlength{\photodim}
      \ifthenelse{\equal{\@photoshape}{circle}}%
        {\setlength{\photodim}{1.3cm}}%
        {\setlength{\photodim}{1.8cm}}%
      \ifthenelse{\equal{\@photoedge}{edge}}%
        {\def\@photoborder{darkgray}}%
        {\def\@photoborder{none}}%
      \begin{tikzpicture}%
        \node[\@photoshape, draw=\@photoborder, line width=0.3mm, inner sep=\photodim, fill overzoom image=\@photo] () {};
      \end{tikzpicture}
    }%
  }
  \newlength{\headertextwidth}
  \newlength{\headerphotowidth}
  \ifthenelse{\isundefined{\@photo}}{
    \setlength{\headertextwidth}{\textwidth}
    \setlength{\headerphotowidth}{0cm}
  }{%
    \setlength{\headertextwidth}{0.76\textwidth}
    \setlength{\headerphotowidth}{0.24\textwidth}
  }%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
  \begin{minipage}[c]{\headertextwidth}
    \ifthenelse{\equal{#1}{L}}{\raggedright}{\ifthenelse{\equal{#1}{R}}{\raggedleft}{\centering}}
    \headerfirstnamestyle{\@firstname}\headerlastnamestyle{{}\acvHeaderNameDelim\@lastname}%
    \\[\acvHeaderAfterNameSkip]%
    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\[\acvHeaderAfterPositionSkip]}}%
  \end{minipage}%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
}


%-------------------------------------------------------------------------------
%               Side Bar Lengths Definitions
%-------------------------------------------------------------------------------
% User Defined
\newlength{\leftcolumnwidth}
\newlength{\columnsmargin}

\newlength{\iconswidth}
\setlength{\iconswidth}{9pt}

%-------------------------------------------------------------------------------
%               Contacts
%-------------------------------------------------------------------------------
% Address
\def\caddressicon{\headeraddressstyle{\icon{}}}
\def\caddress{\headeraddressstyle{\@address}}
% Mobile
\def\cmobileicon{\headersocialstyle{\faMobile}}
\def\cmobile{\headersocialstyle{\@mobile}}
% Github
\def\cgiticon{\headersocialstyle{\href{https://github.com/\@github}{\faGithubSquare}}}
\def\cgituser{\headersocialstyle{\href{https://github.com/\@github}{\@github}}}
% Linkedin
\def\clinkedinicon{\headersocialstyle{\href{https://www.linkedin.com/in/\@linkedinuser}{\faLinkedin}}}
\def\clinkedinuser{\headersocialstyle{\href{https://www.linkedin.com/in/\@linkedinuser}{\@linkedinuser}}}
% Email
\def\cemailicon{\headersocialstyle{\href{mailto:\@email}{\faEnvelope}}}
\def\cemail{\headersocialstyle{\href{mailto:\@email}{\@email}}}


%-------------------------------------------------------------------------------
%               Commands for dual-column and timeline
%-------------------------------------------------------------------------------
\newlength{\headersmargin}
\newlength{\timelinemargin}

% This counter counts major nodes (sections)
\newcounter{sections}
% This counter counts minor nodes (entries). Resets when sections increments.
\newcounter{entries}[sections]

% Converts the values saved by `zref-savepos` to a more convenient unit (pt.)
% Important: if the label is not defined, the value is 0
\newcommand*{\getposy}[1]{\the\dimexpr\zposy{#1}sp\relax}
\newcommand*{\getposx}[1]{\the\dimexpr\zposx{#1}sp\relax}

% Finding tikz coordinates for saved labels
% ----------------------------------------
% Set of command to go from distances (pt. & others) to a position that tikz
% can work with

% Command for the x-shift for labels
\newcommand{\tikzposxshift}{\sidemargin + \leftcolumnwidth + \columnsmargin + \timelinemargin}

% Each of those is defining a command for each type of nodes as the (x,y)
% adjustment might be slightly different (e.g. higher line)

% Usage: \tikzpossection{<section-label>} e.g. \tikzpossection{A0}
\newcommand{\tikzpossection}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} + 5pt]current page.south west)
}
% Usage: \tikzposentry{<entry-label>} e.g. \tikzpossection{A1}
\newcommand{\tikzposentry}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} - 7pt]current page.south west)
}
% Usage: \tikzposend{<end-label>} e.g. \tikzpossection{A4-end}
\newcommand{\tikzposend}[1]{
    ([xshift=\tikzposxshift,yshift=\getposy{#1} - 0pt]current page.south west)
}


\newcommand{\timeline}[1]{
    % The timeline works by saving positions (A, A1, ...) in the aux file.
    % On a second pass, we can then draw the timeline in the middle of the two
    % columns (absolute positioning) using the positions we gathered.
    % There are a couple corner cases to the logic, but in general we want to
    % declare the nodes {A, A1, ..., A5-end} then draw the lines from one to
    % the next.
    %
    %              (A0) ● Work Experience
    %                   │
    %              (A1) ○ Position                                    Location
    %                   │ company                                         Date
    %                   │ ▪ Did this thing
    %          (A1-end) │ ▪ Did that other thing
    %                   │
    %              (A2) ○ Other Position                              Location
    %                   │ company                                         Date
    %                   │ ▪ Did this thing
    %          (A2-end) │ ▪ Did that other thing
    %
    %              (B0) ● Education
    %                   │
    %              (B1) ○ Degree Name
    %                   │ university                                      Date
    %                   │ ▪ Learnt this thing
    %          (B1-end) │ ▪ Learnt that other thing
    %                   │
    %              (B2) ○ Other Degree                                Location
    %                   │ university                                      Date
    %                   │ ▪ Learnt this thing
    %          (B2-end) │ ▪ Learnt that other thing
    %                   │
    %              (B3) ○ Other Degree                                Location
    %                   │ university                                      Date
    %                   │ ▪ Learnt this thing
    %          (B3-end) │ ▪ Learnt that other thing
    %
    % When looking at this diagram, we realise that we want to define and draw:
    % (A0) -- (A1) -- (A2) -- (A2-end)
    % (B0) -- (B1) -- (B2) -- (B3) -- (B3-end)
    \begin{tikzpicture} [
        remember picture,
        overlay,
        color=darktext,
        % Style for sections node (currently: filled black circle)
        section/.style={circle, fill, inner sep=0pt, minimum size=7pt},
        % Style for entries node (currently: empty black circle, smaller)
        entry/.style={circle, draw, inner sep=0pt, minimum size=5pt},
    ]
        % We don't know how many sections exist: iterate from the first letter
        % to some upper-bound (e.g. +10).
        \foreach \s[count=\i from 0] in {#1,...,G}{
            % If the section exists, create a node `S0`
            \ifnum \zposy{\s0}>0
                \node[section] (\s0) at \tikzpossection{\s0} {};
            \fi
            % We don't know how many entries exist
            % Iterate from the first index to some upper-bound (e.g. +10)
            \foreach \e[remember=\e as \laste (initially 0)] in {1,...,10}{
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
}


%-------------------------------------------------------------------------------
%               Footer
%-------------------------------------------------------------------------------
% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  %\fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#1}}
}

%-------------------------------------------------------------------------------
%               Section, Subsection (titles)
%-------------------------------------------------------------------------------
% Define a section for CV
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{%
  \sectionstyle{#1}
  \phantomsection
  %\color{gray}\vhrulefill{0.9pt}
  % Increase the sections counter (A3 -> B0)
  \stepcounter{sections}
  % Save the position of the section as 'A0' in the aux file
  \zsavepos{\Alph{sections}\arabic{entries}}
  \vspace{\acvSectionTopSkip}
}

% Define a subsection for CV
% Usage: \cvsubsection{<subsection-title>}
\newcommand{\cvsubsection}[1]{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \subsectionstyle{#1}
  \phantomsection
}

%-------------------------------------------------------------------------------
%               Paragraph, Entries (contents)
%-------------------------------------------------------------------------------

% Highlight keywords you want to emphasize in your CV (e.g. technical skills)
% Usage: \keyword{<keywords>}
\newcommand*{\keyword}[1]{#1}

% Define a paragraph for CV
\newenvironment{cvparagraph}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \paragraphstyle
}{%
  \par
  \vspace{2mm}
}

% Define an about me summary
\newenvironment{cvsummary}{%
  \fontsize{10pt}{1em}\bodyfontlight\upshape\color{text}
}{ }

% Define an environment for cventry
\newenvironment{cventries}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
}{%
  % Save the position of the end of section as 'A1-end' in the aux file
  \zsavepos{\Alph{sections}\arabic{entries}-end}
  \end{center}
}

% Use to highlight the duration of an experience
% Usage: \duration{<duration>} (e.g. \duration{2 months})
\newcommand*{\duration}[1]{}

% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
\newcommand*{\cventry}[5]{%
  % Increase the entry counter (A0 -> A1)
  \stepcounter{entries}
  % Save the position of the entry as 'A1' in the aux file
  \zsavepos{\Alph{sections}\arabic{entries}}
  \vspace{\acvEntryTopSkip}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 3.5cm} R{3.5cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrydatestyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\
      \entrypositionstyle{#1} & \entrydatestyle{#4} \\}
    \multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}}
  \end{tabular*}%
}

% Define an environment for cvsubentry
\newenvironment{cvsubentries}{%
  \begin{center}
}{%
  \end{center}
}
% Define a subentry of cv information
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

%-------------------------------------------------------------------------------
%               Within Entries (list, nested lists, ...)
%-------------------------------------------------------------------------------


% Define an environment for cvitems(for cventry)
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

\newenvironment{cvitemsnested}{
    \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
}{
    \end{itemize}
}


%-------------------------------------------------------------------------------
%               Skills & Keywords
%-------------------------------------------------------------------------------
% Starts a new category of skills
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\skillcategory}[1]{\skilltypestyle{#1}}
\newenvironment{cvskills}{
  %\vspace{\acvSectionContentTopSkip}
  \vspace{-1.5mm}
}{}

% Environment for complex skills boxes with tikz
\newcommand*{\skillicon}[2]{
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

% Environment for skills with tcolorbox
\newtcolorbox{skillbox}{
    colframe=lighttext,
    colback=white,
    tcbox raise base,
    height=11pt,
    width=1.47cm,
    halign=center,
    boxrule=0.4pt,
    nobeforeafter,
    on line,
    top=0pt,
    bottom=0pt,
    left=-1pt,
    right=-1pt,
}

\newcommand*{\skill}[1]{
    \begin{skillbox}\skillsetstyle{#1}\end{skillbox}
    %\skillsetstyle{#1}
}

\newenvironment{skillstable}{
    %\renewcommand{\arraystretch}{0.8}
    %\setlength{\tabcolsep}{0pt}
    %\tabularx{\textwidth}{|X|X|X|}
    %\begin{tabular}{|l|c|r|}
    \vspace{-0.3mm}
}{
    %\end{tabular}
    %\endtabularx
    \vspace{-2.0mm}
}



%-------------------------------------------------------------------------------
%               Projects
%-------------------------------------------------------------------------------
% Define an entry of cv project
% Usage: \cvproject{<subject>}{<duration>}{<description>}
\newcommand*{\cvproject}[3]{%
  \vspace{-2.0mm}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 2.5cm} R{2.5cm}}
    \entrytitlestyle{#1} & \entrydatestyle{#2} \\
    \descriptionstyle{#3} & \\
    %\multicolumn{2}{L{\textwidth}}{}
  \end{tabular*}%
}
