\name{SPACECAP}
\alias{SPACECAP}

\title{Fits spatially-explicit capture recapture models}

\description{

Function \code{SPACECAP} is the workhorse of the pkg{SPACECAP} package. It opens a Graphical User Interface (GUI) where the user selects the files containing the capture-recapture data, selects options for the model to run, and specifies the variables for the MCMC estimation. MCMC samples from the posterior distributions of the parameters are generated and saved as files, together with summary statistics and kernel density plots.

}

\usage{
SPACECAP()
}

\details{

%%% Mike moved the description of the model to its own page together with the priors.

\bold{Installing SPACECAP Version 1.1.0}

%% This should work for all platforms.

You must have a recent version (R 2.15.3 or higher) of program \R installed on your computer. If necessary, go to \url{http://www.r-project.org/}, select a mirror, then download and install R for your platform.

Launch \R, and at the ">" prompt type

\code{install.packages("SPACECAP")}

and press Enter. \code{SPACECAP} must be upper case and in quotes. You will be asked to select a CRAN mirror and may need to confirm that \R should create a personal library for your packages. \pkg{SPACECAP} depends on \pkg{coda}, and that should be installed automatically at the same time. You only need to install \pkg{SPACECAP} once.

\pkg{SPACECAP} stores its output in subfolders of \R's working directory. You can set the working directory with the File > Change dir... option in the console or by typing \code{setwd(choose.dir())} and browsing to the folder you want the output to go to.

To launch the \pkg{SPACECAP} GUI, you need to have \R open, then at the ">" prompt enter

\code{library(SPACECAP)} \cr
\code{SPACECAP()}

Note the empty parentheses \code{()} after \code{SPACECAP} in the second line.

You will not be able to work in the \R Console while the the \code{SPACECAP} GUI is open.
If you want to work in \R while the analysis is running, you can open another
instance of the \R Console. You can even have several \code{SPACECAP} analyses
running at the same time, by launching them from different \R instances, and they will
use different cores on a multicore computer.

\bold{SECR Analysis using \pkg{SPACECAP}}

Running an SECR Analysis in \pkg{SPACECAP} involves four steps:

1. Setting up the input files \cr
2. Selecting the appropriate model combination \cr
3. Selecting the Markov chain Monte Carlo (MCMC) settings \cr
4. Clicking "Run" on the main menu bar. \cr

\bold{STEP 1: SETTING UP THE INPUT FILES FOR ANALYSIS}

\pkg{SPACECAP} requires three input files:

1. Animal Capture File (Animal ID, trap ID, capture occasion)

2. Trap Deployment File (Trap ID, location and deployment record)

3. State-space File (the Potential Animal Home Range Center locations and habitat suitability indicator for these home range centers)

See the \link{Example files} page for more details and examples.

These three data files can be created using spreadsheet applications such as Microsoft EXCEL or LibreOffice Calc. They must be saved in ASCII comma
separated format \emph{(.csv)}, because \pkg{SPACECAP} can only read these types of input files.

\bold{INPUT FILE 1: Animal Capture Details}

This is a table with 3 columns: Location Number, the Animal Identity Number and the Sampling Occasion number, in that order.
Note that these are all "number" fields: use simple integer numbers.

Each individual captured should be given a unique identification number, ranging from 1 to n, where n is the total number of individuals included in this file. In the example below, the records have been sorted by ANIMAL_ID to facilitate checking that no numbers are missing.

Location Numbers must correspond to the numbers in the Trap Deployment file.

If only 6 animals were photo-captured and identified, the \bold{INPUT FILE 1} for
\pkg{SPACECAP} might look like this:

\tabular{lll}{
LOC_ID    \tab  ANIMAL_ID \tab  SO  \cr
11   \tab  1 \tab  14  \cr
15   \tab  2 \tab  12  \cr
9    \tab  3 \tab  20  \cr
1    \tab  4 \tab  17  \cr
5    \tab  5 \tab  13  \cr
7    \tab  6 \tab  17  \cr
8    \tab  6 \tab  16  \cr
}

For example, the first row of data tells us that Animal ID no 1 was captured at Location ID 11 on the 14th sampling occasion.

The first row of the file must have the exact column headings as shown above, or it will not be recognized by \pkg{SPACECAP}.

\bold{INPUT FILE 2: Trap Deployment Details}

The first column of this file has the Location Number. The next two columns have the X and Y coordinates of the trap location: see the example below. Use a projected coordinate system (ie, in meters, not degrees), such as UTM (Universal Transverse Mercator) or your national grid system.

After these first three columns, there is one column for each trapping occasion. Here, "1" means that a trap was operating at that location on that occasion, "0" means that no trap was operating. You do not have to have a trap at every location for the whole period. In particular, trap malfunction, theft, vandalism, etc. can be accounted for.

An example TRAP DEPLOYMENT DATA file is shown below. This file has 16 locations, but there were only 4 traps, which were moved between locations.

\tabular{lllllllllllllllllllllll}{
LOC_ID \tab X_Coord \tab Y_Coord \tab 1 \tab 2 \tab 3 \tab 4 \tab 5 \tab 6 \tab 7 \tab 8 \tab 9 \tab 10 \tab 11 \tab 12 \tab 13 \tab 14 \tab 15 \tab 16 \tab 17 \tab 18 \tab 19 \tab 20 \cr
1 \tab 619303 \tab 1325966 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
2 \tab 624151 \tab 1325013 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
3 \tab 624722 \tab 1323864 \tab 1 \tab 1 \tab 1 \tab 0 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
4 \tab 621806 \tab 1322453 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
5 \tab 622451 \tab 1320137 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
6 \tab 622599 \tab 1317937 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
7 \tab 623179 \tab 1315941 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
8 \tab 625156 \tab 1315587 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
9 \tab 626022 \tab 1314224 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
10 \tab 627568 \tab 1315494 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
11 \tab 619604 \tab 1324739 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 0 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
12 \tab 621478 \tab 1324515 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \cr
13 \tab 623317 \tab 1323989 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \cr
14 \tab 624406 \tab 1321603 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \cr
15 \tab 624482 \tab 1320577 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \cr
16 \tab 629229 \tab 1319793 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \cr
}

The table shows that the first four locations were operational during sampling occasions 1-5, except that the trap at location 3 was not working on occasion 4. No traps were operational at these sites on occasions 6 to 20.

Again, the first row must have column headings as shown in the example above.

\bold{INPUT FILE 3: Potential Home Range Centers}

This file contains the locations of possible home range centers for all
the animals which might be detected by our traps. These are represented
by a large number of equally spaced points or \emph{pixels} in the form
of a grid. This grid can be produced by GIS software such as ArcView or
QGIS. See the figure on the \link{Example files} page.

To generate this file, you need to decide (1) the extent of the state space, (2) the size of the pixels, and (3) what habitat would be suitable as a home range center for your species.

The extent of the area covered by the file must be big enough to include
the home ranges of animals with a reasonable probability of being
captured. Under the
Gaussian hazard model,
animals with home range centers more than 3 or 4 times the detection
function scale parameter, sigma, from the nearest trap have a negligable
probability of being caught. For the negative exponential model we think
3-4x sigma should also be adequate but recommend checking this for
specific data sets.
Use a guestimate of the home range radius for a preliminary run, and check against the value of sigma produced (see \bold{Things to check} below).

In principle, the state space cannot be too large, but in practice a large area will need a higher value for data augmentation (see below) and will run more slowly. Note that the estimate of density does not depend on the area of the state space, provided that is large enough.

Pixel size is related to home range size. For the animals captured, the
software will estimate the location of the home range center, but has
only pixel centers to choose from. This clearly would not work well if
pixels were larger than home ranges. Pixel areas roughly (1/16) - (1/32)
of a typical home range area would be appropriate. %%%%% Is this right? With the current version, every pixel has approx. 300 neighbours irrespective of how coarse or fine the grid is, so this should not affect run time.
%% I [Andy] changed to 1/16 - 1/32 which I think is pretty stable in most cases.

Note the area of the pixel used, as that must be entered when running \pkg{SPACECAP} and a mistake there will result in a wrong answer for the density.

The potential home-range centers data file consists of a 3 column table. The first two columns are the X and Y coordinates (using the same coordinate system as the trap location file) of the center of each pixel in the state-space. The third column is a habitat suitability indicator, with "1" if the pixel centre lies within suitable habitat or with "0" otherwise. The first few rows of such a file is given below (the actual file will have thousands of rows):

\tabular{lll}{
X_COORD    \tab  Y_COORD \tab  HABITAT  \cr
611734      \tab  1299581 \tab  1  \cr
612301.6    \tab  1299583 \tab  1  \cr
612869.2    \tab  1299585 \tab  0  \cr
613436.9    \tab  1299587 \tab  0  \cr
614004.5    \tab  1299589 \tab  0  \cr
614572.2    \tab  1299591 \tab  0  \cr
615139.8    \tab  1299593 \tab  0  \cr
615707.5    \tab  1299595 \tab  1  \cr
616275.1    \tab  1299597 \tab  1  \cr
616842.8    \tab  1299600 \tab  0  \cr
617410.4    \tab  1299602 \tab  1  \cr
617978.1    \tab  1299604 \tab  1  \cr
618545.7    \tab  1299606 \tab  1  \cr
}

Again, the column headings in the first row must be exactly as shown in the example.

\bold{Entering the file names in \pkg{SPACECAP}}

The "Input Data" panel is the top left portion of the \pkg{SPACECAP} window. Use the Browse buttons to select each of the three input files in turn.

Enter the area of the pixels created for the potential home range centers file (in sq km) in the box below the file names. %%% it must be in sq km.

Click on "OK" in the "Input Data" panel and check the frame at the bottom of the window for status or error messages. To edit your selection, just click on the "Edit" button and start the selection all over again.

\bold{STEP 2: SELECTING THE APPROPRIATE MODEL COMBINATION FOR ANALYSIS}

The Model Definition panel of \pkg{SPACECAP} consists of a set of options to select an appropriate model combination for the Spatial-Capture Recapture Analysis. Model options that are "grayed out" are not available with the current version of \pkg{SPACECAP}. %% There'll be future developments?
%% Maybe now Arjun's back on board.

The model choices are:

1.	\bold{Trap response present OR Trap response absent}
The "Trap response present" option implements a local or "trap-specific" behavioral
response under which the probability of encounter in a trap increases (or decreases) after initial capture in that specific location. This is
in contrast to the conventional "global" behavioral response which implies a response to all traps everywhere after being caught once.

2.   \bold{Spatial Capture-Recapture OR Non-spatial Capture-Recapture}
Select "Spatial Capture-Recapture" for running a spatially explicit capture-recapture analysis, or
"Non-spatial Capture-Recapture" for running a conventional capture-recapture analysis (this is equivalent to the Null
Model "M0" in non-spatial CR analysis)

Note that including a \emph{location-specific} trap response in a \emph{non-spatial} model may lead to spurious results, as the trap response coefficient will pick up the spatial structure in the data.

3.	\bold{Half Normal OR Negative Exponential}

See the discussion of detection functions on the \link{Model and Priors} help page. The half normal
 detection function is generally a good fit to the data.
 This has no effect for non-spatial analysis.

4.	\bold{Bernoulli (binary)  OR Poisson encounter process}
       Currently the analysis is run with the Bernoulli encounter model in which the probability of success is derived
       as the probability of a positive response under a Poisson encounter rate model. This motivates use of the
       complementary log-log link which relates encounter probability to distance and other covariates.

After the model definition is complete, click on "OK" and check the frame at the bottom for status or error messages. To edit your selections, just click on the "Edit" button, change your model definition and click on "OK" again.

\bold{STEP 3: SETTING THE MARKOV-CHAIN MONTE CARLO (MCMC) PARAMETERS}

\pkg{SPACECAP} uses a Markov-Chain Monte Carlo simulation algorithm written in \R to estimate the parameters of the SECR models of Royle et al (2009). (Wikipedia has a short page on Markov chain Monte Carlo methods.) The relevant settings can be set in the MCMC simulation settings panel of \pkg{SPACECAP}.

\bold{No of iterations} - This defines the total number of MCMC iterations for the analysis.

\bold{Burn-in} - This defines the number of initial values to discard during the MCMC analysis. The Geweke diagnostic (see below) will indicate if this is adequate.

\bold{Thinning} - This defines the proportion of iterations included in the output. If thinning = 10, only 1 in 10 of the iterations will be stored.

The number of values returned will be (iterations - burn-in) / thinning. The goodness-of-fit calculations are run for each value returned, and these are slow, so you should aim for about 10,000 values returned.

It is a good idea to do short runs to begin with (say 10,000 iterations with 5,000 burn-in) and do a much longer run to get your final results (at least 100,000 iterations with enough burn-in to give adequate Geweke statistics).

\bold{Data augmentation} - This is the maximum number of uncaught animals in the whole state space, and sets an upper limit to the estimate of N for the MCMC run. If it is too low, the estimate of N and (hence the density) will be incorrect. On the other hand, the run time increases linearly with the data augmentation value. Try an initial value of 5 to 10 times the number of animals captured, and check the output (see the \bold{Things to check} section below) and rerun with a higher value if necessary.

See the \bold{Priors for N and psi} section of the \link{Model and Priors} page.

After the MCMC simulation values have been specified, click on "OK" and check the frame at the bottom for status or error messages. To edit these settings, just click on the "Edit" button, edit these values and click on "OK" again. You are now all set to start the analysis.

\bold{STEP 4: Running the analysis}

Click on "Run" in the top menu bar. This will start the analysis and you will see a progress bar indicating the status of the analysis. Samples from the MCMC chain are reported in the bottom panel in the \pkg{SPACECAP} window and in the \R Console.

Currently, an analysis of the example data set with the default model, 50,000 iterations, 20,000 burnin, thinning by 10, and data augmentation of 350 takes about 9.5 hours on a fast computer.

\bold{Results}

The posterior density estimates along with standard errors appear as a table in the middle panel of the \pkg{SPACECAP} window and in the \R Console when
the analysis is complete. This table also reports estimates of parameters lam0, sigma, and psi. For a non-spatial analysis, sigma will be reported as \code{NA}. If the analysis was run with
trap response present, beta, p1, and p2 are reported; the probability of capture (if trap to home range center distance is zero) = p1 before the first capture and p2 afterwards. With no behavioural response, these will be equal, and beta will be zero.

\pkg{SPACECAP} produces a number of files which you will find in a folder called "output_<timestamp>" in your working directory (use \code{getwd()} so see your working directory path):

  \tabular{ll}{
  info_<timestamp>.txt \tab a text file with background information and diagnostics. \cr
  param_val_<timestamp>.csv \tab the full MCMC chain for each parameter \cr
  summary_stats_<timestamp>.csv \tab summary statistics for each parameter\cr
  pixeldensities_val_<timestamp>.csv \tab estimates of density for each of the pixels in the potential home-range centers input file (for spatial models) \cr
  detectionFunction_<timestamp>.jpg \tab a plot of the detection function (spatial models) \cr
  density_lam0_<timestamp>.jpg \tab a density plot for the lam0 parameter \cr
  density_N_<timestamp>.jpg \tab a density plot for N \cr
  density_psi_<timestamp>.jpg \tab a density plot for psi \cr
  density_sigma_<timestamp>.jpg \tab a density plot for sigma (spatial models) \cr
  density_beta_<timestamp>.jpg \tab a density plot for beta (behavioural response models) }

\bold{Things to check}

\emph{Data augmentation:} Check the density plot for psi; the right-hand tail
 should not get up to 1. The same applies to the density plot for N; the
 tail should not approach the upper limit of the prior. If it does, rerun
 the analysis with a higher value for data augmentation.

\emph{State-space extent:} For spatial models, check the detection function plot and the detection
probability for the smallest trap to state space edge distance. The detection
probability for any animals with home ranges outside must be very small.
%% can we indicate how small it should be? < 0.0001 ? For the example data set and
%% neg. exp. the prob is 0.000239.

\emph{Convergence:} The Geweke test (see \code{\link[coda]{geweke.diag}}) compares
 the means of the first 10\% and the last 50\% of the values in the chains. The
 z-scores are in the info file and should all be between -1.6 and +1.6.
 If not, rerun with a longer burn-in period.

\emph{Sample size:} The values in the chain are not independent, and successive
 values are correlated. The effective sample size is the sample size adjusted
 for this autocorrelation (see \code{\link[coda]{effectiveSize}}). Effective
 sizes of several hundred are adequate for point estimates (mean or median), but
 many thousand are needed to get good estimates of the 95\% HDI and to get smooth
 density curves. If necessary, run with more iterations (and higher thinning).

\emph{Model fit:} Values of the Bayesian P-value (Royle et al. 2011) close to 0 or 1 imply that the model is inadequate. No simple solution to this, you will have to think of a better model!
}

\author{
Arjun M. Gopalaswamy, Jeffrey A. Royle, Michael E Meredith, Pallavi Singh, Devcharan Jathanna, N. Samba Kumar and K. Ullas Karanth
}

\references{

Geweke, J. 1992. Evaluating the accuracy of sampling-based approaches to the calculation of posterior moments. In: Bayesian
  Statistics, \bold{4} (Bernardo, J. M. et al., Eds), 169-193. Oxford University Press.

Royle, J. A., K. U. Karanth, A. M. Gopalaswamy and N. S. Kumar. 2009. Bayesian inference in camera trapping studies for a class of spatial capture-recapture models. \emph{Ecology} \bold{90(11)}, 3233-3244.

Royle, J. A., M. Kery and J. Guelat. 2011. Spatial capture-recapture models for search-encounter data. \emph{Methods in Ecology and Evolution} \bold{2}:602-611.

}

\examples{
SPACECAP()
}
