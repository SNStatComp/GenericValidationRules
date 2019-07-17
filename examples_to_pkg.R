
files <- dir("pkg/inst/tinytest/data/",pattern="\\.csv$",full.names = TRUE)

for (in_file in files){
  d <- read.csv(in_file, stringsAsFactors = FALSE)
  out_file <- file.path("pkg/data",basename(in_file))
  write.csv2(d, file = out_file, row.names=FALSE)
}

