FROM rocker/shiny
ADD shiny_demo /srv/shiny-server/shiny_demo
RUN R -e "install.packages(c('ggplot2'), repos='http://cran.rstudio.com/')"