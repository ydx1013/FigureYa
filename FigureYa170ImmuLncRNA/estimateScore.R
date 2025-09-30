###
### $Id: estimateScore.R 13 2016-09-28 19:32:16Z proebuck $
###


##-----------------------------------------------------------------------------
estimateScore <- function(input.ds,
                          output.ds,
                          platform=c("affymetrix", "agilent", "illumina")) {

    ## Check arguments
    stopifnot(is.character(input.ds) && length(input.ds) == 1 && nzchar(input.ds))
    stopifnot(is.character(output.ds) && length(output.ds) == 1 && 
