{smcl}
{* *! version 1.0.0  7/19/21}{...}
{vieweralsosee "inflate" "help inflate"}{...}
{viewerjumpto "Syntax" "inflate##syntax"}{...}
{viewerjumpto "Description" "inflate##description"}{...}
{viewerjumpto "Updating the CPI series" "inflate##updatecpi"}{...}
{viewerjumpto "Options" "inflate##options"}{...}
{viewerjumpto "Examples" "inflate##examples"}{...}
{viewerjumpto "Author" "inflate##author"}{...}
{viewerjumpto "Acknowledgements" "inflate##acknowledgements"}{...}
{title:Title}

{pstd}
{hi:inflate} {hline 2} Inflate variables to real values using the CPI-U series


{marker syntax}{title:Syntax}

{pstd} Inflate variables

{p 8 15 2}
{cmd:inflate}
{varlist} {ifin}{cmd:,}
{{cmdab:y:ear(}{it:{varname}}{cmd:)}| {opth start(int)}} {opth end(int)} [{it:options}]


{synoptset 35 tabbed}{...}
{synopthdr :options}
{synoptline}
{syntab :Main}
{synopt :{cmdab:y:ear(}{it:{varname}}{cmd:)}}year variable {p_end}
{synopt :{opth start(int)}}start date between 1913-today. {p_end}
{synopt :{opth end(int)}}end date between 1913-today. {p_end}

{syntab :More Precise Time Periods}
{synopt :{cmdab:h:alf(}{it:{varname}}{cmd:)}}half variable {p_end}
{synopt :{cmdab:q:uarter(}{it:{varname}}{cmd:)}}quarter variable {p_end}
{synopt :{cmdab:m:onth(}{it:{varname}}{cmd:)}}month variable {p_end}

{syntab : Variable Creation}
{synopt :{cmdab:gen:erate(}{it:{varname}}{cmd:)}}specify the name of the new inflated variable {p_end}
{synopt :{opt replace}}replaces variable with the inflated version instead of making a new variable  {p_end}
{synopt :{opt keepcpi}}keeps cpi values and multiplier used to inflate the variables {p_end}

{syntab : CPI Data}
{synopt :{opt update}}updates CPI to most recent release from FRED {p_end}
{synopt :{opt cpicheck}}opens the current CPI data file stored {p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:inflate} is a one-line command to inflate (or deflate) variables from any year to any other year based on the Consumer Price Index All Urban, All Items U.S. City Average. {cmd:inflate} adjusts to the year specified in option end() using either the constant starting year in start() or a year variable that can change across observations in year(). Inflation is according to the simple formula: newvar = oldvar*(CPI_end / CPI_start or CPI_year). 

{pstd}
By default, {cmd:inflate} generates a new inflated variable suffixed with "_real."

{pstd}
{cmd:inflate} relies on functionality introduced in Stata 16, specifically frame/frames.

{marker updatecpi}{...}
{title:Updating the CPI series}

{pstd}
{cmd:inflate} uses the {browse "https://fred.stlouisfed.org/series/CPIAUCNS":CPIAUCNS} series from FRED.

{phang}
To update the CPI series stored locally to the most recent release, run:

{pmore}
{cmd:inflate}, update

{pstd}
{cmd:inflate} stores the CPI series in a Stata dta file in {bf:{help sysdir:PLUS}}/i folder. This file contains annual, biannual, and quarterly averages in addition to the monthly values. 

{phang}
To view your current cpi data file, run:

{pmore}
{cmd:inflate}, cpicheck

{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}{cmdab:y:ear(}{it:{varname}}{cmd:)} chooses the year variable used to match with starting CPI values. Inflates each observation to the end() date based on its year in the specified variable. 


{phang}{opth start(int)}  chooses a constant starting year as the base for inflation to end(). 

{pmore} You can also choose a more precise time period as the start date including year-half, year-quarter, or year-month. More precise time periods are inputted as year then the time period type, then which half, quarter, or month. For example, to inflate from July 1985, input 1985M07 or 1985M7.

{phang}{opth end(int)}  chooses a constant end year to inflate to.  

{pmore} You can also choose a more precise time period as the end date including year-half, year-quarter, or year-month. More precise time periods are inputted as year then the time period type, then which half, quarter, or month. For example, to inflate to the first quarter of 2021, input 2021Q01 or 2021Q1.

{dlgtab:More Precise Time Periods}

{phang}{cmdab:h:alf(}{it:{varname}}{cmd:)} specifies the half variable used to match with starting CPI values. {cmdab:h:alf(}{it:{varname}}{cmd:)} must be used in combination with {cmdab:y:ear(}{it:{varname}}{cmd:)}. Inflates each observation to the end() date based on its year and half values in the specified variables.

{phang}{cmdab:q:uarter(}{it:{varname}}{cmd:)} specifies the quarter variable used to match with starting CPI values. {cmdab:q:uarter(}{it:{varname}}{cmd:)} must be used in combination with {cmdab:y:ear(}{it:{varname}}{cmd:)}. Inflates each observation to the end() date based on its year and quarter values in the specified variables.

{phang}{cmdab:m:onth(}{it:{varname}}{cmd:)}  specifies the month variable used to match with starting CPI values. {cmdab:m:onth(}{it:{varname}}{cmd:)}  must be used in combination with {cmdab:y:ear(}{it:{varname}}{cmd:)}. Inflates each observation to the end() date based on its year and month values in the specified variables.

{dlgtab:Variable Creation}

{phang}{cmdab:gen:erate(}{it:{varname}}{cmd:)} allows you to specify the new variable names, rather than naming each variable oldvariablename_real.

{phang}{opt replace} replaces the current variable with an inflated version, dropping the original variable.

{phang}{opt keepcpi} generates variables with the base CPI values, the end CPI value, and CPI_end / CPI_base as start_cpi, end_cpi, and inflator in addition to the new inflated variables.

{dlgtab:CPI Data}

{phang}{opt update} updates the CPI series to the most recent FRED release using their API. Replaces CPI data in the {bf:{help sysdir:PLUS}}/i folder.

{phang}{opt checkcpi} opens the local CPI data that {cmd:inflate} is using in the current Stata session.

{marker examples}{...}
{title:Examples}

{marker example_binning}{...}
{pstd}{bf:Example 1: One variable with a constant start year}

{pstd}Plot the percentage of the population that are small children in each state.{p_end}
{phang2}. {stata gen babyperc=poplt5/pop*100}{p_end}
{phang2}. {stata maptile babyperc, geo(state)}{p_end}

{pstd}Small children are most common in the Western US.
But the bin of states with the highest percentage of children is much higher than the other 5 bins.{p_end}

{pstd}Try coloring each bin proportionally to its median value.{p_end}
{phang2}. {stata maptile babyperc, geo(state) propcolor}{p_end}
{phang2}. {stata matrix list r(midpoints)}{p_end}

{pstd}Most US states have a fairly similar proportion of children, but the highest group stands out.{p_end}

{pstd}Instead of grouping the states into quantile bins, now try coloring states individually and displaying a full spectrum in the legend.{p_end}
{phang2}. {stata maptile babyperc, geo(state) spopt(legstyle(3)) cutvalues(5(0.5)13)}{p_end}

{pstd}The proportion of children is very homogeneous across states, with Utah as a major exception.
Three other states also stand out a bit from the rest.{p_end}

{pstd}{bf:Example 2: Multiple variables}

{pstd}{bf:Example 3: year() and quarter()}


{marker author}{...}
{title:Author}

{pstd}Sean McCulloch{p_end}
{pstd}sean_mcculloch@brown.edu{p_end}


{marker acknowledgements}{...}
{title:Acknowledgements}

{pstd}{cmd:inflate} blah blah.
