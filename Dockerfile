FROM rocker/shiny
ADD shiny_test /srv/shiny-server/shiny_test
RUN R -e "install.packages(c('shinydashboard','devtools'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('AnalytixWare/ShinySky')"