\name{SPACECAP-package}
\alias{SPACECAP-package}
\docType{package}
\title{A Program to Estimate Animal Abundance and Density using Bayesian Spatially-Explicit Capture-Recapture Models}
\description{
    \pkg{SPACECAP} is a user-friendly software package for estimating animal 
    densities using closed model capture-recapture sampling based 
    on photographic captures. This approach substantially deals with individual 
    heterogeneity in capture probabilities resulting from the locations
    of traps relative to animal home range centres.
    
    \pkg{SPACECAP} uses a Bayesian approach and Markov chain Monte Carlo simulation to generate samples from the posterior distribution of each parameter, as described by Royle et al (2009). This gives non-asymptotic inferences which are appropriate for small samples of capture data typical of photo-capture studies.
    
    See \link{Model and Priors} for details of the model, \link{Example files} for the kind of data required, and \link{SPACECAP} for instructions on running the software. 
    
    For analysis of similar models using maximum likelihood methods, see Borchers and Efford (2008) and the \pkg{secr} package. 
    
}
\details{
\tabular{ll}{
Package: \tab SPACECAP\cr
Type: \tab Package\cr
Version: \tab 1.1.0\cr
Date: \tab 2014-07-07\cr
License: \tab GPL (>=2)\cr
LazyLoad: \tab yes\cr
}
}

\section{Important changes to the output in version 1.1.0}{

The values for sigma, the scale parameter of the detection function, are now correctly reported. The units are those used for the trap and habitat pixel coordinates (usually meters).

Units for density are now animals per sq km, not animals per 100 sq km. The densities in the file \file{pixeldensities_val_<time>.csv} are also in animals per sq km, not animals per pixel.

Analysis is much faster. Current version provided results at less than 50 per cent of the time taken in version 1.0.6 on some data sets.  
}

\section{Suggested Citation}{

\bold{PUBLICATION}
Arjun M. Gopalaswamy, Jeffrey A. Royle, James E. Hines, Pallavi Singh, Devcharan Jathanna, N. Samba Kumar and K. Ullas Karanth (2012). Program SPACECAP: software for estimating animal density using spatially explicit capture-recapture models. \emph{Methods in Ecology and Evolution} 3(6): 1067-1072.

\bold{PACKAGE VERSION}  
Arjun M. Gopalaswamy, Jeffrey A. Royle, Michael E. Meredith, Pallavi Singh, Devcharan Jathanna, N. Samba Kumar and K. Ullas Karanth (2014). SPACECAP: An R package for estimating animal density using spatially explicit capture-recapture models.
Wildlife Conservation Society - India Program, Centre for Wildlife Studies, Bengaluru, India. 
Version 1.1.0.

The software could be cited as follows: "We used the software SPACECAP (Gopalaswamy et al. 2012) version 1.1.0 (Gopalaswamy et al. 2014) for the analysis".

}


\author{
Arjun M. Gopalaswamy, Jeffrey A. Royle, Michael E. Meredith, Pallavi Singh, Devcharan Jathanna, N. Samba Kumar and K. Ullas Karanth 
}
\references{

Borchers, D. L., and M. G. Efford. 2008. Spatially explicit maximum likelihood methods for capture-recapture studies.   \emph{Biometrics} 64:377-385.

Royle, J. A., K. U. Karanth, A. M. Gopalaswamy and N. S. Kumar. 2009. Bayesian inference in camera trapping studies 
  for a class of spatial capture-recapture models. \emph{Ecology} \bold{90(11)}, 3233-3244. 
}
