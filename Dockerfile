FROM rocker/shiny
<<<<<<< HEAD
ADD shiny_test /srv/shiny-server/calf-health-manager
RUN R -e "install.packages(c('shinydashboard','devtools', 'shinysky'), repos='http://cran.rstudio.com/')"
RUN R -e "library devtools::install_github('AnalytixWare/ShinySky')"
=======
ADD calf-health-manager /srv/shiny-server/calf-health-manager
RUN R -e "install.packages(c('shinydashboard','devtools'), repos='http://cran.rstudio.com/')"
>>>>>>> 551db51a7469572ee428ee09421166a858550f6b
