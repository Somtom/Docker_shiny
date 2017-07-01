FROM rocker/shiny
ADD shiny_test /srv/shiny-server/shiny_test
RUN R -e "install.packages(c('ggplot2'), repos='http://cran.rstudio.com/')"