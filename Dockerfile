FROM rocker/shiny
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN apt-get update && apt-get install -y libssl-dev 
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinyjs', 'openssl', 'data.table'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('AnalytixWare/ShinySky')"

