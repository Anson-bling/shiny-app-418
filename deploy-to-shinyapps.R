
#deploy to shinyapps.io
#first you will need an account

#install.packages('rsconnect')

#name is account name, get both your authentication token and secret in your account
rsconnect::setAccountInfo(name='nathan-langholz-rb',
                          token='<hide>',
                          secret='<SECRET>')

setwd("~/Documents/Egnyte/Private/nlangholz/UCLA/shiny-app-418")
library(rsconnect)
rsconnect::deployApp(appDir = 'docker/app/',appName="clusters")

#this is now running at
#https://nathan-langholz-rb.shinyapps.io/clusters/