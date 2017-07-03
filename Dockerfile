FROM rocker/shiny
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN R -e "install.packages(c('shinydashboard','devtools'), repos='http://cran.rstudio.com/')"