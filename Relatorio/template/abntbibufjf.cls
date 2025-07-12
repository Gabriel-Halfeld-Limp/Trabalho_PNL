%% abntbibufjf.cls, v-2 JB-LP-LA
%% 
  %% Copyright 2014 Jos\'e Barbosa (ICE-UFJF), Larissa Pinheiro (CDC-UFJF), L\'ivia Alonso (CDC-UFJF).
  %
  % This work may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either 
  % version 1.3 of this license or (at your option) any later 
  % version. The latest version of this license is in
  %       http://www.latex-project.org/lppl.txt
  % and version 1.3 or later is part of all distributions of LaTeX
  % version 2005/12/01 or later.
  %
  % This work has the LPPL maintenance status `maintained'.
  % 
  % The Current Maintainer of this work is Jos\'e Barbosa (ICE-UFJF).
  %
  % This work consists of the files abntbibufjf.cls.
% 
% 
%  
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
%%Os acentos foram desprezados neste arquivo.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{abntbibufjf}[2019/09/05 v 2]


\RequirePackage{ifthen}


\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptions\relax
\LoadClass[12pt,a4paper]{memoir}

% ------------------------------------------------------------------------


\newcommand{\ifnotempty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}} 

\RequirePackage[hypertexnames=false, hidelinks]{hyperref}    
\pdfstringdefDisableCommands{\def\\{, }\def\and{; }}

\RequirePackage{bookmark}

\RequirePackage[brazil]{babel} % A palavra brazil foi substituida por english %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{enumitem}


\RequirePackage{calc}

%
\newcommand{\folhaderostoname}{Folha de rosto}
\newcommand{\epigraphname}{Ep\'igrafe}
\newcommand{\dedicatorianame}{Dedicat\'oria}
\newcommand{\agradecimentosname}{\bfseries AGRADECIMENTOS} % A palavra AGRADECIMENTOS foi substituida por ACKNOWLEDGEMENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\anexoname}{\bfseries ANEXO}
\newcommand{\anexosname}{Anexos}
\newcommand{\apendicename}{\bfseries AP\^ENDICE} % A palavra AP\^ENDICE foi substituida por APPENDIX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\apendicesname}{Ap\^endices}
\newcommand{\orientadorname}{Orientador:}
\newcommand{\coorientadorname}{Coorientador:}
\newcommand{\folhadeaprovacaoname}{\bfseries FOLHA DE APROVA\c{C}\~AO}
\newcommand{\resumoname}{\bfseries RESUMO} 
\newcommand{\listadesiglasname}{\bfseries LISTA DE ABREVIATURAS E SIGLAS} % A frase LISTA DE ABREVIATURAS E SIGLAS foi substituida por LIST OF ABBREVIATIONS AND ACRONYMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\listadesimbolosname}{\bfseries LISTA DE SÍMBOLOS}
\newcommand{\fontename}{Fonte} % A palavra Fonte foi substituida por Source %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\notaname}{Nota}
\newcommand{\legendaname}{Legenda} % A palavra Legenda foi substituida por Caption %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --
\addto\captionsbrazil{% 
  \renewcommand{\contentsname}{\bfseries SUM\'ARIO} %%
  \renewcommand{\bibname}{\bfseries REFER\^ENCIAS}
  \renewcommand{\indexname}{\bfseries \'INDICE}
  \renewcommand{\listfigurename}{\bfseries LISTA DE ILUSTRA\c{C}\~{O}ES}
  \renewcommand{\listtablename}{\bfseries LISTA DE TABELAS}
}

%% --
\def\au@classname{abntbibufjf} 

\newif\if@eu@ilhookcalled\@eu@ilhookcalledfalse
\newif\if@eu@hasil\@eu@hasilfalse

\def\au@eu@ilaux{\global\@eu@hasiltrue}
\def\au@eu@ilhook{%
  \if@eu@ilhookcalled\else
    \global\@eu@ilhookcalledtrue
    \global\@eu@hasiltrue
    \immediate\write\@auxout{%
      \string\au@eu@ilaux{}^^J
    }%
    \typeout{* \au@classname: Il }%
  \fi
}
\newcommand{\auaddilcmd}[1]{%
  \begingroup
  \let\au@temp#1
  \expandafter\gdef\expandafter#1\expandafter{%
    \expandafter\au@eu@ilhook\au@temp}%
  \endgroup
}
\newcommand{\auaddilenv}[1]{%
  \begingroup
  \expandafter\auaddilcmd\expandafter{\csname#1\endcsname}%
  \endgroup
}
\AtBeginDocument{\auaddilenv{figure}}

% ------------------------------------------------------------------------

\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout

\OnehalfSpacing
\AtBeginDocument{\setlength{\afterchapskip}{\onelineskip}} 

%% ---

\setlength{\parindent}{1.3cm}

\setlength{\parskip}{4pt}

\setlength{\cftbeforechapterskip}{0pt} 

%% ----------------------------------------------------------------------------------

% ------------------------------------------------------------------------

\newcommand{\chapterfont}{\rmfamily} 
\newcommand{\chapterfontsize}{\normalsize}

\newcommand{\partfont}{\chapterfont}
\newcommand{\partfontsize}{\chapterfontsize}

\newcommand{\sectionfont}{\chapterfont}
\newcommand{\sectionfontsize}{\normalsize}

\newcommand{\subsectionfont}{\sectionfont}
\newcommand{\subsectionfontsize}{\normalsize}

\newcommand{\subsubsectionfont}{\subsectionfont}
\newcommand{\subsubsectionfontsize}{\normalsize}

\newcommand{\subsubsubsectionfont}{\subsectionfont}
\newcommand{\subsubsubsectionfontsize}{\normalsize}

% ------------------------------------------------------------------------

\newcounter{bookmarkcounter} 
\setcounter{bookmarkcounter}{0}
\newcommand{\AUbookmarkthis}[1]{%
  \addtocounter{bookmarkcounter}{1}%
  \phantomsection\pdfbookmark[0]{#1}{chapterb\arabic{bookmarkcounter}}
}

\newcommand{\pretextualchapter}[1]{%
  \addtocounter{bookmarkcounter}{1}%
  \AUbookmarkthis{#1}%
  \chapter*[#1]{#1}%
  }
\provideboolean{apendiceousecao}      
\setboolean{apendiceousecao}{false}


% ------------------------------------------------------------------------


\renewcommand{\foottextfont}{\small}
\setlength{\footmarkwidth}{1.2em}
\setlength{\footmarksep}{0em}
\footmarkstyle{\footnotesize{\textsuperscript{#1}}\hfill}

  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
%%%}
%------------------------------------

\captiondelim{~\textendash~} 
\captionnamefont{\normalsize}
\captiontitlefont{\normalsize}
\indentcaption{0pt} 
\captionstyle[\centering]{\centerlastline} 
\newcommand{\larguratexto}[1]{ }%\changecaptionwidth \captionwidth{#1}}

\newcommand{\configureseparator}{\captiondelim{: }}

%% Macro original para incluir Fonte após as ilustrações e tabelas.
%\newcommand{\fonte}[2][\fontename]{%
%  \M@gettitle{#2}%
%  \memlegendinfo{#2}%
%  \par
%  \begingroup
%  \captionstyle{\raggedright}{\raggedright} 
%     \@parboxrestore
%     \if@minipage
%       \@setminipage
%     \fi
%     \small
%     \captiondelim{: }
%     \@makecaption{\small 
%     #1}{\ignorespaces \small 
%     #2}\par
%   \endgroup}

%% Macro modificada para incluir Fonte após as ilustrações e tabelas.
\newcommand{\fonte}[3][\fontename]{
	\M@gettitle{#3}%
	\memlegendinfo{#3}%
	\par
	\begingroup
		\begin{minipage}{#2}
			\captionstyle{\raggedright}{\raggedright} 
			\small
			\captiondelim{: }
			\@makecaption{\small 
			#1}{\ignorespaces\small 
			#3}\par
		\end{minipage}
	\endgroup
}

%% Macro original para incluir Legendas após as ilustrações com múltiplas figuras.
%\newcommand{\legenda}[2][\legendaname]{%
%  \M@gettitle{#2}%
%  \memlegendinfo{#2}%
%  \par
%  \begingroup
%  \captionstyle{\raggedright}{\raggedright} 
%     \@parboxrestore
%     \if@minipage
%       \@setminipage
%     \fi
%     \small
%     \captiondelim{: }
%     \@makecaption{\small 
%     #1}{\ignorespaces \small 
%     #2}\par
%   \endgroup}

%% Macro modificada para incluir Legendas após as ilustrações com múltiplas figuras.
\newcommand{\legenda}[3][\legendaname]{%
	\M@gettitle{#3}%
	\memlegendinfo{#3}%
	\par
	\begingroup
		\begin{minipage}{#2}
			\captionstyle{\raggedright}{\raggedright} 
			\small
			\captiondelim{: }
			\@makecaption{\small 
			#1}{\ignorespaces \small 
			#3}\par
		\end{minipage}
		\vspace{0.25cm}
	\endgroup
}

\AtEndPackage{caption}{
	\AtBeginDocument{%
		\DeclareCaptionLabelSeparator{dash}{~\textendash ~}
		\DeclareCaptionFont{normalsize}{\normalsize}
		\captionsetup{
			labelseparator=dash,
		}
%		\renewcommand{\configurecaptions}{%
%			\captionsetup{
%				singlelinecheck=false}}
		\renewcommand{\configureseparator}{\captionsetup{labelsep=colon}}
	}
}

% ------------------------------------------------------------------------

\setsecnumdepth{paragraph}
\settocdepth{paragraph}
\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
\maxsecnumdepth{paragraph}

\newcommand{\subsubsubsection}{\paragraph}
\newcommand{\cftbeforesubsubsubsectionskip}{\cftbeforeparagraphskip}
\newcommand{\cftsubsubsubsectionfont}{\cftparagraphfont}
\newcommand{\setsubsubsubsecheadstyle}{\setparaheadstyle}

\setafterparaskip{1.0\onelineskip plus 0.5\onelineskip minus 0.2\onelineskip}
\setparaheadstyle{\normalfont\rmfamily\raggedright} 

%-------------------------------------------------------------------


\renewcommand{\cftfigurename}{\figurename\space} 
\renewcommand*{\cftfigureaftersnum}{\hfill \textendash \hfill} 
\renewcommand{\cftfigureafterpnum}{\cftparfillskip} 


\newcommand{\tipoilust}[1]{\renewcommand{\cftfigurename}{#1 \space}
\renewcommand{\figurename}{#1}
}

\newcommand{\ilustvaria}{
\renewcommand{\fnum@figure}{} 
}

\newcommand{\listilustvaria}{
\setlength{\cftfigurenumwidth}{24pt}
\setlength{\cftfigureindent}{0pt}
\begingroup
\renewcommand\numberline[1]{} 
\listoffigures*
\endgroup
}


\renewcommand{\cfttablename}{\tablename\space}
\renewcommand*{\cfttableaftersnum}{\hfill \textendash \hfill}	
\renewcommand{\cfttableafterpnum}{\cftparfillskip} 

 
\renewcommand{\tocheadstart}{\chapterfont}

\renewcommand*{\cftchapterdotsep}{\cftdotsep}

\setlength{\cftbeforechapterskip}{0pt plus 0pt}
\renewcommand*{\insertchapterspace}{}

\cftinsertcode{A}{}

\newlength{\cftlastnumwidth}
\setlength{\cftlastnumwidth}{\cftsubsubsectionnumwidth+1em}

\newcommand{\tocprintchapter}{}
\newcommand{\tocinnonumchapter}{}
\newcommand{\tocprintchapternonum}{}
\newcommand{\tocpartapendices}{}
\newcommand{\tocpartanexos}{}

  \cftinsertcode{A}{\renewcommand{\cftchapteraftersnum}{\hfill \textendash \hfill}}
  
  \cftsetindents{part}{0em}{\cftlastnumwidth}
  \cftsetindents{chapter}{0em}{\cftlastnumwidth}
  \cftsetindents{section}{0em}{\cftlastnumwidth}
  \cftsetindents{subsection}{0em}{\cftlastnumwidth}
  \cftsetindents{subsubsection}{0em}{\cftlastnumwidth}
  \cftsetindents{paragraph}{0em}{\cftlastnumwidth}
  \cftsetindents{subparagraph}{0em}{\cftlastnumwidth}
  % ----------------------------------------------------------- AQUI
  \renewcommand{\tocprintchapter}{%
    \addtocontents{toc}{\vskip0.45em\cftsetindents{chapter}{0em}{\cftlastnumwidth}}}  %AQUIIIIIIIII (vskip)
  
  \renewcommand{\tocinnonumchapter}{%
    \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{2em}}%
    \cftinserthook{toc}{A}}
  
  \renewcommand{\tocprintchapternonum}{%
    \addtocontents{toc}{\vskip0.45em\cftsetindents{chapter}{\cftlastnumwidth}{2em}}} %AQUIIIIIIIII (vskip) para espaçar a Referência
  
  \renewcommand{\tocpartapendices}{%
    \addtocontents{toc}{\cftsetindents{part}{\cftlastnumwidth}{2em}}
    \cftinserthook{toc}{A}}
  
  \renewcommand{\tocpartanexos}{%
    \addtocontents{toc}{\cftsetindents{part}{\cftlastnumwidth}{2em}}
    \cftinserthook{toc}{A}}
  
 
\newcommand{\phantompart}{%
  \bookmarksetup{startatroot}
  \phantomsection
}
% ------------------------------------------------------------------------

\provideboolean{innonumchapter}  
\setboolean{innonumchapter}{true}
\makechapterstyle{abnt}{%
  \renewcommand{\chapterheadstart}{} 

  \ifx \chapternamenumlength \undefined
    \newlength{\chapternamenumlength}
  \fi

     \setlength{\beforechapskip}{0pt}
     \renewcommand{\chaptitlefont}{\chapterfont\chapterfontsize}
%%%   }
  
  \renewcommand{\chapnumfont}{\chaptitlefont}
  \renewcommand{\parttitlefont}{\partfont\partfontsize}
  \renewcommand{\partnumfont}{\partfont\partfontsize}
  \renewcommand{\partnamefont}{\partfont\partfontsize}
  
  
  \setsecheadstyle{\sectionfont\sectionfontsize
  }
  \setsubsecheadstyle{\subsectionfont\subsectionfontsize
  }
  \setsubsubsecheadstyle{\subsubsectionfont\subsubsectionfontsize
  }
  \setsubsubsubsecheadstyle{\subsubsubsectionfont\subsubsubsectionfontsize
  }
  
  \renewcommand{\chapternamenum}{}
  
  \renewcommand{\printchaptername}{%
   \chaptitlefont
   \ifthenelse{\boolean{apendiceousecao}}{\appendixname}{}%
  }
  
  \def\printchaptertitle##1{%
    \chaptitlefont%
    \ifthenelse{\boolean{innonumchapter}}{\centering
    {##1}}{%
    % else  
      \ifthenelse{\boolean{apendiceousecao}}{\centering%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        {##1}%
      }{%
        \settowidth{\chapternamenumlength}{\printchaptername\printchapternum\afterchapternum}%
        \parbox[t]{\columnwidth-\chapternamenumlength}{%
        {##1}}}%
    }    
  }
       
  \renewcommand{\printchapternum}{%
     \tocprintchapter
     \setboolean{innonumchapter}{false}
     \bfseries %%
     \chapnumfont%
     \space\thechapter\space%
     \ifthenelse{\boolean{apendiceousecao}}{%
       \tocinnonumchapter
       \space--\space%
     }{} % 
  }
  \renewcommand{\afterchapternum}{}
  
  
  \renewcommand\printchapternonum{%
     \tocprintchapternonum
     \setboolean{innonumchapter}{true}%
    }
}
\chapterstyle{abnt}


\makepagestyle{abntchapfirst}
\makeoddhead{abntchapfirst}{}{}{\small\thepage}

% ------------------------------------------------------------------------

\newcommand{\pretextual}{%
  \aliaspagestyle{chapter}{empty}
  \pagestyle{empty}
  \aliaspagestyle{cleared}{empty}
  \aliaspagestyle{part}{empty}
}
\renewcommand{\frontmatter}{\pretextual} 

\AtBeginDocument{\pretextual}

% ------------------------------------------------------------------------

\newcommand{\titulo}[1]{\title{#1}}
\newcommand{\inseretitulo}{\thetitle}

\newcommand{\autor}[1]{\author{#1}}
\newcommand{\insereautor}{\theauthor}

\let\olddate\date
\renewcommand{\date}[1]{\AtBeginDocument{\olddate{#1}}}
\newcommand{\ano}[1]{\date{#1}}
\newcommand{\insereano}{\thedate}

\providecommand{\inseredia}{}
\newcommand{\dia}[1]{\renewcommand{\inseredia}{#1}}

\providecommand{\inseremes}{}
\newcommand{\mes}[1]{\renewcommand{\inseremes}{#1}}

\providecommand{\insereinstituicao}{}
\newcommand{\instituicao}[1]{\renewcommand{\insereinstituicao}{#1}}

\providecommand{\inserefaculdade}{}
\newcommand{\faculdade}[1]{\renewcommand{\inserefaculdade}{#1}}

\providecommand{\inserelocal}{}
\newcommand{\local}[1]{\renewcommand{\inserelocal}{#1}}

\providecommand{\inserenatureza}{}
\newcommand{\natureza}[1]{\renewcommand{\inserenatureza}{#1}}

\providecommand{\insereobjeto}{}
\newcommand{\objeto}[1]{\renewcommand{\insereobjeto}{#1}}

\providecommand{\insereprograma}{}
\newcommand{\programa}[1]{\renewcommand{\insereprograma}{#1}}

\providecommand{\inserearea}{}
\newcommand{\area}[1]{\renewcommand{\inserearea}{#1}}

\providecommand{\inseresubtitulo}{}
\newcommand{\subtitulo}[1]{\renewcommand{\inseresubtitulo}{#1}}

\providecommand{\inserekeywordI}{}
\newcommand{\keywordI}[1]{\renewcommand{\inserekeywordI}{#1}}

\providecommand{\inserekeywordII}{}
\newcommand{\keywordII}[1]{\renewcommand{\inserekeywordII}{#1}}

\providecommand{\inserekeywordIII}{}
\newcommand{\keywordIII}[1]{\renewcommand{\inserekeywordIII}{#1}}

\providecommand{\inserefinalcatalog}{}
\newcommand{\finalcatalog}[1]{\renewcommand{\inserefinalcatalog}{#1}}

\providecommand{\insereautorR}{}
\newcommand{\autorR}[1]{\renewcommand{\insereautorR}{#1}}

\providecommand{\insereorientadorR}{}
\newcommand{\orientadorR}[1]{\renewcommand{\insereorientadorR}{#1}}

\providecommand{\inserecoorientadorR}{}
\newcommand{\coorientadorR}[1]{\renewcommand{\inserecoorientadorR}{#1}}

\providecommand{\insereorientadorOU}{}
\providecommand{\insereorientador}{}
\newcommand{\orientador}[2][\orientadorname]%
  {\renewcommand{\insereorientadorOU}{#1}%
   \renewcommand{\insereorientador}{#2}}

\providecommand{\inserecoorientadorOU}{}
\providecommand{\inserecoorientador}{}
\newcommand{\coorientador}[2][\coorientadorname]%
  {\renewcommand{\inserecoorientadorOU}{#1}%
   \renewcommand{\inserecoorientador}{#2}}
   
\providecommand{\insereorientadorTitulo}{}
\newcommand{\orientadorTitulo}[1]{\renewcommand{\insereorientadorTitulo}{#1}}
   
\providecommand{\insereorientadorDegree}{}
\newcommand{\orientadorDegree}[1]{\renewcommand{\insereorientadorDegree}{#1}}
   
\providecommand{\inserecoorientadorTitulo}{}
\newcommand{\coorientadorTitulo}[1]{\renewcommand{\inserecoorientadorTitulo}{#1}}   
   
\providecommand{\inserecoorientadorDegree}{}
\newcommand{\coorientadorDegree}[1]{\renewcommand{\inserecoorientadorDegree}{#1}}   

\providecommand{\inseretipodocumento}{}
\newcommand{\tipodocumento}[1]{\renewcommand{\inseretipodocumento}{#1}}


% ------------------------------------------------------------------------

\newenvironment{capa}{\begin{titlingpage}}{\end{titlingpage}\cleardoublepage}

\newcommand{\inserecapa}{%
  \begin{capa}%
   \begin{center}
    {\chapterfont \bfseries \MakeUppercase{\insereinstituicao} \par \MakeUppercase{\inserefaculdade} \par \MakeUppercase{\insereprograma}}
    \vfill
    {\chapterfont \bfseries \insereautor}
    \vfill
    \chapterfont{\bfseries \inseretitulo \mdseries \ifnotempty{\inseresubtitulo}{\textbf{:} \inseresubtitulo}}
    \vfill
    \inserelocal \par \insereano 
   \end{center}
   \end{capa}
}

\newenvironment{folhaderosto}[1][\folhaderostoname]{\clearpage\AUbookmarkthis{#1}}{\newpage}%

%% --
\newcommand{\folhaderostocontent}{
  \begin{center}
    {\chapterfont \bfseries \insereautor} 
    \vspace*{\fill}
    \begin{center}
      {\chapterfont \bfseries \inseretitulo \mdseries 
        \ifnotempty{\inseresubtitulo}{\textbf{:} \inseresubtitulo}}
    \end{center}
    \vspace*{\fill}
      \ifnotempty{\inserenatureza}{%
      \hspace{.45\textwidth}
      \begin{minipage}{.5\textwidth}
      	\SingleSpacing
         \inserenatureza
      \end{minipage}
       \vspace*{\fill}
    }
  \end{center} 
   {\insereorientadorOU ~\insereorientadorTitulo ~\insereorientador, \insereorientadorDegree \par }
   {\ifnotempty{\inserecoorientador}
       {\inserecoorientadorOU ~\inserecoorientadorTitulo ~\inserecoorientador, \inserecoorientadorDegree}
    }
    \vfill
  \begin{center}  
    \inserelocal \par \insereano   
  \end{center}
}
%% --

\newcommand{\inserefolhaderosto}[1]{%
  \begin{folhaderosto}{#1}
     \folhaderostocontent
  \end{folhaderosto}}


%% --
\newcommand{\inserecatalog}{
\thispagestyle{empty}

\ifthenelse{\boolean{@twoside}}
{}
{\addtocounter{page}{-1}}

{
\vspace*{15cm}
\begin{center}
\begin{minipage}[c]{13cm}
\begin{center}
Ficha catalogr\'afica elaborada atrav\'es do Modelo Latex do CDC da UFJF com os dados fornecidos pelo(a) autor(a)
\end{center}
\end{minipage}

\fbox{\hspace*{0.3cm} \begin{minipage}[c]{12.5cm} \SingleSpacing \small
  \insereautorR . \par
  \hspace*{0.45cm} \inseretitulo \ifnotempty{\inseresubtitulo}{: \inseresubtitulo} ~/ \insereautor. \textendash ~\insereano .\par
  \hspace*{0.5cm} \pageref{LastPage} p. \if@eu@hasil : il.~\fi \\[12pt]
  \hspace*{0.45cm} \insereorientadorOU ~\insereorientador \par
    {\ifnotempty{\inserecoorientador}{%
       {\hspace*{0.45cm} \inserecoorientadorOU ~\inserecoorientador \par }%
    }
   }
  \hspace*{0.45cm} \insereobjeto~\textendash~\insereinstituicao, \inserefaculdade. \insereprograma, \insereano. \\[12pt]
  \hspace*{0.5cm}  \inserefinalcatalog 
  \vspace*{12pt}
  \hspace*{0.3cm}
\end{minipage} \hspace*{0.3cm}}
\end{center}}
}


\newcommand{\inicfolhaaprov}{
\begin{center}
    {\chapterfont \bfseries \insereautor}

    \vfill
    \begin{center}
      {\chapterfont\bfseries\inseretitulo \mdseries \ifnotempty{\inseresubtitulo}{\textbf{:} \inseresubtitulo}}
    \end{center}
    \vfill
    
    \hspace{.45\textwidth}
    \begin{minipage}{.5\textwidth}
        \inserenatureza
    \end{minipage}%
    \vfill
   \end{center}
}

%%%
  
  
\newenvironment{folhadeaprovacao}[1][\folhadeaprovacaoname]{%
   \clearpage%
   \AUbookmarkthis{#1}%
   \begin{Spacing}{1.0}
}{\end{Spacing}%
\cleardoublepage}

\newenvironment{dedicatoria}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \AUbookmarkthis{\dedicatorianame}
    }{\pretextualchapter{#1}}
    \vspace*{\fill}
    \begin{quote}
    \begin{flushright}
    \addtolength{\leftskip}{4cm}
  }{%
    \end{flushright}
    \end{quote}
  \cleardoublepage}
  
\newenvironment{agradecimentos}[1][\agradecimentosname]{%
   \pretextualchapter{#1}
  }{%
  \cleardoublepage}
  
\newenvironment{epigrafe}[1][]{%
   \ifthenelse{\equal{#1}{}}{%
    \AUbookmarkthis{\epigraphname}
    }{\pretextualchapter{#1}}
    \vspace*{\fill}
    \begin{quote}
    \addtolength{\leftskip}{4cm}
    }{%
  \end{quote}
  \cleardoublepage}

    \setlength\absleftindent{0cm}
    \setlength\absrightindent{0cm}
     \renewcommand{\abstracttextfont}{\normalfont\normalsize}

\newenvironment{resumo}[1][\resumoname]{%
   \AUbookmarkthis{#1}
   \renewcommand{\abstractnamefont}{\chaptitlefont}
   \renewcommand{\abstractname}{\bfseries 
   {#1}}
   \begin{abstract}
  }{\end{abstract}%
\cleardoublepage}


\newenvironment{siglas}{%
  \pretextualchapter{\listadesiglasname}
  \begin{symbols} 
  \setlength{\itemsep}{-0.5em}
  \setlength{\labelwidth}{\widthof{\bfseries LABSOLSAR}} 
  }{
  \end{symbols}
  \cleardoublepage
  }

  
\newenvironment{simbolos}{%
  \pretextualchapter{\listadesimbolosname}
\begin{symbols} 
\setlength{\itemsep}{-0.5em} 
}{%
\end{symbols}
  \cleardoublepage
}


\newenvironment*{citacao}[1][default]{%
   \list{}%
   \small%
   \addtolength{\leftskip}{4cm}%{\citacaorecuo}%
   \item[]%
   \begin{SingleSpace}%
   \ifthenelse{\not\equal{#1}{default}}{\itshape\selectlanguage{#1}}{}%
 }{%
   \end{SingleSpace}%
   \endlist}%

%% --
\newlist{alineas}{enumerate}{1}
\setlist[alineas,1]{label={\alph*)},topsep=0pt,itemsep=0pt,leftmargin=\parindent+\labelwidth-\labelsep}%
\newlist{subalineas}{enumerate}{1}
\setlist[subalineas,1]{label={--},topsep=0pt,itemsep=0pt,leftmargin=*}%
%% --
  
\newlength{\signwidth} 
\setlength{\signwidth}{10cm} 
\newlength{\signthickness} 
\setlength{\signthickness}{1pt}
\newlength{\signskip} 
\setlength{\signskip}{1cm} 
  
\newcommand{\assinatura}[1]{
  \begingroup\par\centering 
  \parbox[t]
  {\signwidth}{\SingleSpacing\vspace*{\signskip}\centering%
  \rule{\signwidth}{\signthickness}\\%
  \nopagebreak #1\par}
  \par\endgroup}

% ------------------------------------------------------------------------

\newcommand{\textual}{%
    \pagestyle{simple} 
    \aliaspagestyle{chapter}{abntchapfirst}
  \nouppercaseheads%
  \bookmarksetup{startatroot}% 
\aliaspagestyle{cleared}{simple} 
  }
\renewcommand{\mainmatter}{\textual}

% ------------------------------------------------------------------------

\newcommand{\postextual}{\phantompart}
\renewcommand{\backmatter}{\postextual}

%---
   
\newcommand*{\sistautordata}{\usepackage[authoryear, round]{natbib} 
\setlength{\bibhang}{0pt}   
\renewcommand*{\bibfont}{\raggedright}  
}
   
\let\oldthebibliography=\thebibliography
\let\endoldthebibliography=\endthebibliography
\renewenvironment{thebibliography}[1]{%
\setlength{\afterchapskip}{\lineskip}
\renewcommand*{\biblistextra}{\raggedright}
\begin{oldthebibliography}{#1}%
\begin{SingleSpacing}
}%
{%
\end{SingleSpacing}
\end{oldthebibliography}%
}
%%---

\newcommand\@switch[1]{ \@writefile{toc}{\renewcommand*{\cftappendixname}{#1 \space}} }
\newcommand{\switchchapname}[1]{ \protected@write \@auxout {}{\string\@switch{#1} }}

\newcommand{\AUapendiceconfig}[2]{%
 \setboolean{apendiceousecao}{true}%
 \renewcommand{\appendixname}{#1}
 \renewcommand{\appendixpagename}{#2}
 \renewcommand{\appendixtocname}{#2}
 
 \switchchapname{#1}
 \renewcommand*{\cftappendixname}{#1 \space}
}

\newenvironment{apendicesenv}{%
 \AUapendiceconfig{\apendicename}{\apendicesname}
 \begin{appendix}
}{
 \end{appendix}
 \setboolean{apendiceousecao}{false}
 \bookmarksetup{startatroot}
}

\newenvironment{anexosenv}{%
 \cftinserthook{toc}{AAA}
 
 \AUapendiceconfig{\anexoname}{\anexosname}
 \begin{appendix}
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}{
 \end{appendix}
 \setboolean{apendiceousecao}{false}
 \bookmarksetup{startatroot}
}

% --- 


