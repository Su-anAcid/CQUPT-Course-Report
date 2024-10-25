\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{cqupt}
[2024/10/22 v1.0 Simple LaTeX Template for Experiment Report]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @version: v1.0 																  	  %
% @brief: 框线采用对showframe重新定义绘制，部分布局排版规则修改自cumcmthesis模板		   %
% @defects: 1）正文与框线距离过近，且不易于调整。										  %
% 			2）图像位于页首时，可能会遮挡住上框线。										  %
% 			3）代码片段跨页时，可能会遮盖住下框线。若且一行内代码过长会超出页面。		    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		

\newif\if@bwprint\@bwprintfalse
\newif\if@preface\@prefacetrue

%% Tokens definition
\newcommand\cqupt@tokens@title{}
\newcommand*\cqupt@tokens@coursename{}
\newcommand*\cqupt@tokens@coursenum{}
\newcommand*\cqupt@tokens@place{}
\newcommand*\cqupt@tokens@exptime{}
\newcommand*\cqupt@tokens@oninstructor{}
\newcommand*\cqupt@tokens@offinstructor{}
\newcommand*\cqupt@tokens@expname{}

\newcommand*\coursename[1]{\renewcommand{\cqupt@tokens@coursename}{#1}}
\newcommand*\coursenum[1]{\renewcommand{\cqupt@tokens@coursenum}{#1}}
\newcommand*\place[1]{\renewcommand{\cqupt@tokens@place}{#1}}
\newcommand*\exptime[1]{\renewcommand{\cqupt@tokens@exptime}{#1}}
\newcommand*\oninstructor[1]{\renewcommand{\cqupt@tokens@oninstructor}{#1}}
\newcommand*\offinstructor[1]{\renewcommand{\cqupt@tokens@offinstructor}{#1}}
\newcommand*\expname[1]{\renewcommand{\cqupt@tokens@expname}{#1}}

%% Options Declaration
\DeclareOption{bwprint}{\@bwprinttrue}
\DeclareOption{withoutpreface}{\@prefacefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%% Executing Options
\ExecuteOptions{}
\ProcessOptions\relax

%% Loading Class
\LoadClass[a4paper,12pt]{article}

%% Required Packages
\RequirePackage{ifxetex}
\RequireXeTeX
\ifxetex\else
\ClassError{experimentreport}{You must use the `xelatex' driver}{Just choose `xelatex', no `pdflatex' or `latex' and so on.}
\fi
%% 中文支持与数学排版
\RequirePackage{ctex}           % 支持中文排版
\RequirePackage{amsmath}        % 提供数学公式排版功能

%% 编程语言语法高亮
\RequirePackage{xcolor}         % 提供多种颜色支持
\RequirePackage{listings}       % 用于代码高亮显示
\RequirePackage{algorithm}      % 用于算法排版
\RequirePackage{algpseudocode}  % 提供算法伪代码的排版

%% 表格与图形排版
\RequirePackage{setspace}       % 设置文档行间距
\RequirePackage{graphicx}       % 提供图形包含功能
\RequirePackage{array}          % 增强表格列定义功能
\RequirePackage{longtable}      % 用于创建跨页表格
\RequirePackage{booktabs,tabularx}  % 提供更专业的表格线条和自适应宽度的表格
\RequirePackage{multirow}       % 用于表格中跨行的单元格合并
\RequirePackage{subcaption}		% 用于插双图

%% 页面布局与引用
\RequirePackage{geometry}       % 用于页面布局设置
\RequirePackage{hyperref}       % 提供超链接功能
\RequirePackage{cleveref}       % 提供智能自动化的交叉引用
\RequirePackage{float} 			%

%% 文档定制与排版
\RequirePackage{indentfirst}    % 确保文档首段自动缩进
\RequirePackage{caption}        % 定制浮动体标题的样式
\RequirePackage{enumitem}       % 定制列表环境的样式
\RequirePackage{ulem}           % 提供下划线功能
\RequirePackage{calc}           % 用于尺寸计算，方便设置长度
\RequirePackage[titletoc,title]{appendix}

%% 调整间隔, 让表格更好看些
\RequirePackage{bigstrut}
%% 在跨行表格中输入定界符
\RequirePackage{bigdelim}
% 保护脆落命令
\RequirePackage{cprotect}

% 页面和字体设置
\geometry{showframe,hmargin=2cm,vmargin=2cm}
% \pagestyle{empty}% 在整个文档中去除页码
\renewcommand*{\baselinestretch}{1.38}
\setlength\parindent{2em}
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setCJKfamilyfont{kai}[AutoFakeBold]{simkai.ttf}
\newcommand*{\kai}{\CJKfamily{kai}}
\setCJKfamilyfont{song}[AutoFakeBold]{SimSun}
\newcommand*{\song}{\CJKfamily{song}}

%% Drawing Frame Lines
\renewcommand*{\Gm@pageframes}{
	\vb@xt@\z@
	{
		\ifGm@showcrop
		\vb@xt@\z@
		{
			\vskip-1\Gm@truedimen in\vskip\Gm@layoutvoffset
			\hb@xt@\z@
			{
				\hskip-1\Gm@truedimen in\hskip\Gm@layouthoffset
				\vb@xt@\Gm@layoutheight
				{
					\let\protect\relax
					\hb@xt@\Gm@layoutwidth{\Gm@cropmark(-1,1,-3,3)\hfil\Gm@cropmark(1,1,3,3)}
					\vfil
					\hb@xt@\Gm@layoutwidth{\Gm@cropmark(-1,-1,-3,-3)\hfil\Gm@cropmark(1,-1,3,-3)}
				}
			\hss
			}
		\vss
		}
		\fi


		\ifGm@showframe
		\if@twoside
		\ifodd\count\z@
		\let\@themargin\oddsidemargin
		\else
		\let\@themargin\evensidemargin
		\fi
		\fi
		\moveright\@themargin%
		\vb@xt@\z@{%
			\vskip\topmargin%
			\vskip\headheight%
			\vskip\headsep

			\vb@xt@\z@{\vss\Gm@hrule}%
			\@tempdima\textwidth
			\advance\@tempdima by \marginparsep
			\advance\@tempdima by \marginparwidth
			\if@mparswitch
			\ifodd\count\z@
			\Gm@vrules@mpi
			\else
			\Gm@vrules@mpii
			\fi
			\else
			\Gm@vrules@mpi
			\fi
			\vb@xt@\z@{\vss\Gm@hrule}%
			\vskip\footskip%
			\vss}%
		\fi%
	}
}%
\renewcommand*{\Gm@vrules@mpi}{%
	\hb@xt@\@tempdima{\llap{\Gm@vrule}\ignorespaces
		\hskip \textwidth\Gm@vrule}
	}%
\def\Gm@hrule{%
    \hrule height 0.3pt depth\z@ width \textwidth
}
\def\Gm@vrule{%
\vrule width 0.3pt depth\z@ height 1\textheight
}

%% Title Creation
\setlength{\arrayrulewidth}{0.3pt}
\renewcommand{\maketitle}{%
	\song
	\begin{center}%
		\renewcommand{\arraystretch}{1.2}%
		\begin{tabular}{|p{24mm}|p{58mm}|p{24.602mm}|p{46mm}|}%
			\hline
			\textbf{课程名称} &\cqupt@tokens@coursename & \textbf{课程编号} & \cqupt@tokens@coursenum \\
			\hline
			\textbf{实验地点} &\cqupt@tokens@place & \textbf{实验时间} &\cqupt@tokens@exptime \\
			\hline
			\textbf{校外指导教师} &\cqupt@tokens@offinstructor  & \textbf{校内指导教师} & \cqupt@tokens@oninstructor \\
			\hline
			\textbf{实验名称} & \multicolumn{3}{l|}{\cqupt@tokens@expname} \\
			\hline
			\textbf{评阅人签字} &       & \textbf{成绩} &  \\
			\hline
		\end{tabular}%
	\end{center}%
}

%% Section Formatting
\setcounter{secnumdepth}{3}
\def\@seccntformat#1{\csname the#1\endcsname\ }
\renewcommand\thesection{\thinspace\thinspace\chinese{section}、}
\renewcommand\thesubsection{\arabic{subsection}.}
\renewcommand\thesubsubsection{\thesubsection\thinspace\thinspace\arabic{subsubsection}}
\renewcommand\section{\@startsection {section}{1}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{2ex \@plus.2ex}
	{\normalfont\Large\bfseries}}
	
\renewcommand\subsection{\@startsection {subsection}{1}{\z@}
	{-2.25ex\@plus -1ex \@minus -.2ex}  % 上方间距
	{1.5ex \@plus .2ex}                 % 下方间距
	{\normalfont\large\bfseries\hspace{0.01cm}}}  % 增加左侧缩进

\renewcommand\subsubsection{\@startsection {subsubsection}{1}{\z@}
	{-2ex\@plus -1ex \@minus -.2ex}  % 上方间距
	{1.5ex \@plus .2ex}                 % 下方间距
	{\normalfont\normalsize\bfseries\hspace{0.01cm}}}  % 增加左侧缩进
% 设置enumerate列表的左侧缩进
\setlist[enumerate,1]{left=2em}
\setlist[enumerate,2]{left=3em} % 可选
% \setlength\parindent{10em} % 调整为所需的缩进

%% 代码显示设置
\renewcommand{\algorithmicrequire}{\textbf{Input:}}  
\renewcommand{\algorithmicensure}{\textbf{Output:}} 
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\lstset{
  frame=tblr,                    % 边框
  aboveskip=3mm,                 % 上方空间
  belowskip=3mm,                 % 下方空间
  showstringspaces=false,        % 不显示字符串中的空格标记
  columns=flexible,              % 字符列宽可变
  framerule=0.6pt,               % 边框粗细
  rulecolor=\color{gray!35},     % 边框颜色
  backgroundcolor=\color{gray!5},% 背景颜色
  basicstyle={\small\ttfamily},  % 基本样式
  numbers=none,                  % 不显示行号
  numberstyle=\tiny\color{gray}, % 行号样式
  keywordstyle=\color{blue},     % 关键字样式
  commentstyle=\color{dkgreen},  % 注释样式
  stringstyle=\color{mauve},     % 字符串样式
  breaklines=true,               % 自动换行
  breakatwhitespace=true,        % 在空格处断行
  tabsize=1,                     % 制表符大小
  xleftmargin=20pt,              % 左边距
  xrightmargin=20pt,             % 右边距
}

%% 浮动环境设置
% 默认情况下, \LaTeX{} 要求每页的文字至少占据 20%,否则该页就只单独放置一个浮动环境,
% 而这通常不是我们想要的, 我们将这个要求降低到 5%.
\renewcommand*{\textfraction}{0.05}
% 有时如果多个浮动环境连续放在一起, \LaTeX{}
% 会将它们分在几个不同页，即使它们可在同一页放
% 得下. 我们可以通过修改 |\topfraction| 和 |\bottomfraction| 分别设置顶端和底端的浮
% 动环境的最大比例.
 \renewcommand*{\topfraction}{0.9}
 \renewcommand*{\bottomfraction}{0.8}
% 有时\LaTeX{}会把一个浮动环境单独放在一页,
% 我们要求这个环境至少要占据 85% 才能单独放在一页.
% 注意:  |\floatpagefraction| 的数值必须小于 |\topfraction|.
 \renewcommand*{\floatpagefraction}{0.85}

%% 关于图片 graphicx
 % 如果图片没有指定后缀, 依次按下列顺序搜索
 \DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}
 % 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}{pictures/}%
  {picture/}{pic/}{pics/}{image/}{images/}}
 % 图表标题
\DeclareCaptionFont{song}{\songti}
\DeclareCaptionFont{minusfour}{\zihao{-4}}
\DeclareCaptionFont{five}{\zihao{5}}
\captionsetup[figure]{%
	format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
	labelsep=quad, % 分隔符是一个空格
	font={song,five,bf}, % 图的字体, 宋体5号
	position=bottom % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
\captionsetup[table]{%
	format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
	labelsep=quad, % 分隔符是一个空格
	font={song,five,bf}, % 表的字体, 宋体5号
	position=top % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}

%% 修改tabular 环境, 设置表格中的行间距为正文行间距.
\let\mcm@oldtabular\tabular
\let\mcm@endoldtabular\endtabular
\renewenvironment{tabular}%
	{\bgroup%
	\renewcommand{\arraystretch}{1.38}%
	\mcm@oldtabular}%
	{\mcm@endoldtabular\egroup}

%% 列表环境设置
\setlist{%
	topsep=0.3em, % 列表顶端的垂直空白
	partopsep=0pt, % 列表环境前面紧接着一个空白行时其顶端的额外垂直空白
	itemsep=0ex plus 0.1ex, % 列表项之间的额外垂直空白
	parsep=0pt, % 列表项内的段落之间的垂直空白
	leftmargin=1.5em, % 环境的左边界和列表之间的水平距离
	rightmargin=0em, % 环境的右边界和列表之间的水平距离
	labelsep=0.5em, % 包含标签的盒子与列表项的第一行文本之间的间隔
	labelwidth=2em % 包含标签的盒子的正常宽度；若实际宽度更宽，则使用实际宽度。
}

%% 超链接
\hypersetup{%
%         xetex,
		% unicode=false, % hyperref 和 xetex 同时使用时不能开启 Unicode 选项.
         pdfstartview=FitH,
         CJKbookmarks=true,
         bookmarksnumbered=true,
         bookmarksopen=true,
         colorlinks, %注释掉此项则交叉引用为彩色边框(将colorlinks和pdfborder同时注释掉)
         pdfborder=001,   %注释掉此项则交叉引用为彩色边框
		 allcolors=black,
		 breaklinks=true}%

%%% crefformat settings
\crefformat{figure}{#2图~#1#3}
\crefrangeformat{figure}{图~(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{figure}{图~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\crefformat{table}{#2表#1#3}
\crefrangeformat{table}{表(#3#1#4)\;\~{}\;(#5#2#6)}
\crefmultiformat{table}{表~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\endinput
