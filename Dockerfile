FROM rocker/shiny
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinysky'), repos='http://cran.rstudio.com/')"
RUN R -e "library(devtools) devtools::install_github('AnalytixWare/ShinySky')"

