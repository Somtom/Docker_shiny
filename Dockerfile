FROM rocker/shiny
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN apt-get update && apt-get install -y libssl-dev && apt-get install -y libv8-3.14-dev
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinyjs', 'openssl', 'data.table', 'R4CouchDB', 'V8'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('AnalytixWare/ShinySky')"

