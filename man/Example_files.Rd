\name{Example files}
\alias{Example files}

\title{Example data files}

\description{

The installation of \pkg{SPACECAP} includes a set of three example data files for a camera trap study of tigers. To find the location of the \pkg{SPACECAP} files, use

\code{find.package("SPACECAP")}

The data files are in the \file{extdata} subdirectory. They are Comma Separated Variable (.csv) files which you can open in a text editor or in a spreadsheet program. Copy these files to a location outside the \R library folder if you want to work with them.

}

\section{The capture history file}{

This is called \file{tigerCH.csv}. The columns are headed "LOC_ID", "ANIMAL_ID", and "SO", all in capitals and with underscores instead of spaces. \pkg{SPACECAP} will not accept capture history files without these exact column headings.

All the entries are simple integers. \pkg{SPACECAP} cannot work with alphabetical or alphanumeric IDs, so don't use "TIG02" or "RIVER21". There should be no missing values.

LOC_ID is the location number and must match the LOC_ID in the Trap Deployment file.

ANIMAL_ID identifies the individual animal captured. These must go from 1 to n, where n is the number of animals included in this file. There must be no gaps in the numbering; be careful if you decide to analyse a subset of your data and remove records before the period selected. This file is sorted by ANIMAL_ID to facilitate checking (though the order of the rows is not important for the analysis).

SO is the occasion number that the capture occured. Occasion numbers must correspond to the occasions in the Trap Deployment file.
}

\section{The trap deployment file}{

This is called \file{tigerTraps.csv}. The first three columns are headed "LOC_ID", "X_COORD", and "Y_COORD" and the remaining columns are headed 1 to 48, as there were 48 capture occasions for this study. Your trap location file must have the same column headings.

LOC_ID is the location number and goes from 1 up to the total number of locations, with no gaps. 

X_COORD and Y_COORD are the coordinates of the locations using the UTM (Universal Transverse Mercator) coordinate system. You can use any projected coordinate system using meters (but not latitude and longitude in degrees). The traps are shown by "+" symbols in the figure below.

Following these, there is one column for each trapping occasion. Here, "1" means that a trap was operating at that location on that occasion, "0" means that no trap was operating.

\figure{tigerHabTraps.jpg}
}

\section{The potential home range centers file}{

This is called \file{tigerHabitat.csv}. The columns are headed "X_COORD", "Y_COORD", and "HABITAT"; again these column headings are essential if the file is to be recognized by \pkg{SPACECAP}.

The file covers the whole area where animals captured in our traps could have their home range centers. In this case, it's an area extending 14km beyond the rectangle containing the traps - see the figure above. This area is represented by 9961 pixels, each with an area of 0.336 sq km.

The first two columns in the file give the coordinates of the center of each pixel, using the same coordinate system (UTM) as the trap locations.

The third column indicates whether the pixel has suitable habitat for the animal (1) or not (0). Pixels with suitable habitat are coloured blue in the figure above.
}

\section{Analysing the example data}{

See the \link{SPACECAP} help page for instructions. Load the three example files and enter the pixel area (0.336 sq km). Choose your model and the number of iterations, burn-in and thinning. Data augmentation of 350 is adequate.

A run with the example data and the default model, with 50,000 iterations total,
 20,000 burn-in, thinning by 10, and data augmentation of 350 took 9.5 hours on
 a modern desktop. Convergence was good and effective sample sizes 300 to 500.
 Data augmentation was adequate, and detection probability beyond the edge of
 the state space was less than 3E-13. The density estimate was 0.15 animals per sq km.
 Estimates of detection parameters were sigma = 2,020 m and lam0 = 0.015.
 More iterations would be needed to get reliable 95\% credible intervals.
%%% A similar analysis using v.1.0.6 took 4 days.
}

\references{
Royle, J. A., K. U. Karanth, A. M. Gopalaswamy and N. S. Kumar. 2009. Bayesian inference in camera trapping studies
  for a class of spatial capture-recapture models. \emph{Ecology} \bold{90(11)}, 3233-3244.
}
\keyword{datasets}
