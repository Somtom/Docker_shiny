FROM rocker/shiny
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN apt-get-update
RUN apt-get install -t unstable libgdal-dev
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinysky'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('AnalytixWare/ShinySky')"

