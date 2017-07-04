FROM rocker/shiny
ADD shiny_test /srv/shiny-server/calf-health-manager
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinysky'), repos='http://cran.rstudio.com/')"
RUN R -e "library devtools::install_github('AnalytixWare/ShinySky')"