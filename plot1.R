#Plot 1 R script

#Calculate rough estimate of memory usage - I won't include this in the other plots
#The website says the atributes are Real, so numeric, numeric data use 8 bytes 
#per cell. In researching the different data types, time uses 3-5 bytes, 
#dates use 4 bytes, so we will just use 8 bytes to estimate all of them
#for the rough estimate.
#Referenced a lecture from Data Scientists Toolbox
x <- 2075259*9*8  #calculate bytes
y <- x/2^20 #calculate MB
z <- y/2^10 #calculate GB
z*2  #gives R twice the GB for memory usage
#[1] 0.2783139
#I will need .2783139 GB of memory. My computer is fine, it can handle it.
