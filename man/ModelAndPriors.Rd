\name{Model and Priors}
\alias{Model and Priors}

\title{The \pkg{SPACECAP} model and prior distributions}

\description{

This page describes the model implemented by \link{SPACECAP}, its parameters and prior distributions. The model is described by Royle et al (2009).

}

\section{The Spatial Capture-Recapture Model and its Parameters}{

The model considered in the current version of \pkg{SPACECAP} applies to binary observations y(i,j,k) for individual "i",  
trap "j" and sample occasion (e.g., night) "k". The model is a type of binary regression model, similar to logistic 
regression, in which 

    \deqn{y(i,j,k) ~ Bernoulli(p(i,j,k))}

Here p(i, j, k) is the probability of detecting an individual "i", at trap "j" and sample occasion "k". The probability 
p(i,j,k) is then related to covariates of interest by applying a suitable transformation. In \pkg{SPACECAP} we make 
use of the complementary log-log link transformation. Thus, the simplest possible model (with no spatial component) is:

    \deqn{cloglog(p(i,j,k)) = b0} 
        
where b0 is a parameter to be estimated. The inverse of the cloglog transformation is:
    
    \deqn{p(i,j,k) = 1-exp(-exp(b0))} 
    
    This particular function ('hazard model' in distance sampling)
    arises by considering the binary observations to be formally reduced
    from a Poisson encounter frequency model (see Royle et al 2009 for
    details). That is, p(i,j,k) is the Pr(at least 1 encounter in a
    trap) under the Poisson model.

Spatially-explicit models assume that the probability of detection
decreases as the distance between the trap and the center of the animals
home range increases:

   \deqn{cloglog(p(i,j,k)) = b0 + b2*f[dist(s(i),u(j))]}
   
where s(i) is the location of the home range centre and u(j) the location of the trap and b2 is a regression coefficient.

The Gaussian hazard detection function uses the squared distance between
s(i) and u(i), and then b2 = -1/(2*sigma^2), where sigma is the usual
scale parameter of the normal (Gaussian) distribution. \pkg{SPACECAP}
can also fit a negative exponential hazard function using 
distance (not squared), when b2 = -1/sigma and sigma is the scale parameter of the
negative exponential distribution. The difference in shape of the two
functions is shown in the figure below:

\figure{DetectionFunctions.jpg}
 
 The most general model that \pkg{SPACECAP} presently allows is a model in which 
    
    \deqn{cloglog(p(i,j,k)) = b0 + b1*x(i,j,k) + b2*f[dist(s(i),u(j))]}
    
In this expression x(i,j,k) is an indicator of previous capture of
individual i in trap j. Thus "b1" is a measure of the behavioral
response of an animal to a specific location, ie, it is attracted to or
avoids a location where it was once detected, but does not respond to
traps at other locations where it has not been detected (see Royle et al
2009 for more details).

The user provides a file of potential home range centers (see
\link{Example files}). These constitute the \emph{state space}, S, for
the variable s(i). In \pkg{SPACECAP}, the parameter N is the number of
home range centers located in S (see \bold{Priors for N and psi} below).

Density, D = N/||S|| where ||S|| is the area of the state-space. The
units for Density, D, are animals per sq km.
%% is animals/unit^2 where 'unit' is the canonical unit of the input coordinate system.
%%% I deleted the *100 in the output of density and rewrote prev sentence
%% MM The units of area are those used for the pixel area entered by the user, and
%%  the input dialog asks for area in sq km. The input
%% coordinate system does not, in fact, enter into the calculation.

\pkg{SPACECAP} also reports several derived parameters: 

lam0 = exp(b0), where b0 is the intercept of the regression, is the expected 
       encounter rate of an individual whose home-range centre 
       is exactly at the trap location.  

beta = b1, is the regression coefficient that measures the behavioral response.

psi = the ratio of the number of animals actually present within S to the maximum allowable number (see next section). 

}

\section{Priors for N and psi}{

\pkg{SPACECAP} uses data augmentation (Royle et al 2007), whereby
additional all-zero capture histories are appended to the data to
represent animals not captured. Since the true number of animals present
in the state space but not captured is unknown, a sufficiently large
number of all-zero histories are added, some of which correspond to real
uncaught animals and some to animals which are not available for capture
("phantoms").

N is the number of real animals in the space state; psi is the
probability that an animal in the augmented data set is a real animal in
the space state. The expected value of N is psi x M, where M is the
total number of capture histories in the augmented data set.

psi has a uniform Beta(1, 1) prior.

The variable indicating whether a capture history refers to a real
animal (z = 1) or a phantom (z = 0) is simulated as z ~ Bernoulli(psi),
and N = sum(z). The uniform prior on psi translates into a discrete
Uniform(0, M) prior on N.

This prior is intended to be uninformative, which requires that M >>
N. The user should check after an estimation run that the distribution
of N does not approach M, or equivalently that psi does not approach 1,
by inspecting the density plots generated (see \bold{Things to check} on
the \link{SPACECAP} page). We recommend that the value of M be set such that
psi may be estimated to be between 0.2-0.8. %%% [AMG added this sentence]
}


\section{Priors for the coefficients in the linear predictor}{

All the coefficients in the linear predictor have improper flat priors
on [-infty, infty] for a suitable transformation of the parameter. 

The intercept is log(lam0), where lam0 is the expected number of captures of a single animal in a single trap on a single capture occasion, when the distance between the trap and the center of the animal's home range is zero. The flat prior on log(lam0) implies an uninformative scale prior on lam0;i.e. proportional to 1/lam0. %%% [AMG] Added this to make clear. 

If a behavioral effect is included in the model, such that encounter rate for a specific animal and trap location changes after the first capture, an indicator variable is included in the linear predictor, with value 0 before the first capture and 1 thereafter. This coefficient, beta, has a flat prior.   

For spatially explicit models, the encounter rate is assumed to decline as distance between trap and home range center increases. The distance variable in the linear predictor is either this distance (for a negative exponential detection function) or the squared distance (for a half-normal (Gaussian) detection function). The coefficient of this variable is either -1/sigma (negative exponential) or -1/(2*sigma^2) (half normal) where sigma is the usual scale parameter of the distribution. Sigma has a flat uniform [0,infty] prior. %%% [AMG] Added this sentence.  
%% The flat prior implies ?????

}
\section{Priors for location of home range centers}{

This has a uniform prior, ie, all pixels (potential home range centers) having
good habitat as indicated in the input data have equal probability. 
(Pixels with bad habitat have zero probability of hosting a home range center.)
}

\references{

Royle, J. A., R. M. Dorazio, and W. A. Link. 2007. Analysis of multinomial models with unknown index using data 
  augmentation. \emph{Journal of Computational and Graphical Statistics} \bold{16}:67-85. 

Royle, J. A., K. U. Karanth, A. M. Gopalaswamy and N. S. Kumar. 2009. Bayesian inference in camera trapping studies for a class of spatial capture-recapture models. \emph{Ecology} \bold{90(11)}, 3233-3244.

}
