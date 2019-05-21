#
# This ShinyApp shows how to evaluate and compare
# the quality of linear models.
#

# Use ShinyDashboard
library(shinydashboard)

ui <- dashboardPage(
  
  # Define Header and Sidebar
  dashboardHeader(title = "Iris Clustering"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Cluster", tabName = "cluster", icon = icon("atom")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  

  dashboardBody(
    
    # Define CSS style for the estimation button
    tags$head(tags$style(HTML('
                              .estimation_button {background-color: #33CE67; width: 100%}
                              .estimation_button:hover {background-color: #1DAA4C}
                              '))),
    
    # Define content for each page
    tabItems(
      
      # Estimation Page
      tabItem(tabName = "cluster",
              fluidRow(
                
                # Add box for graph 
                box(
                  title = "K-means Clusters",
                  solidHeader = TRUE,
                  status = "primary",
                  width = 9,
                  plotOutput("plot")
                  ),
                
                # Add box for Accuracy
                valueBoxOutput("accuracy_box", width = 3),

                # Add box for estimation parameters
                box(
                  width = 3,
                  title = "Number of Clusters",
                  status = "primary",
                  solidHeader = TRUE,
               
                  radioButtons("model", "Choose number of clusters:",
                               c("2" = "2",
                                 "3" = "3",
                                  "4" = "4",
                                  "5" = "5")),
                  
                  actionButton("trigger_estimation","Cluster",
                               icon("play"),
                               class="estimation_button"
                               )
                  )
                )


      ),

      # Data Page
      tabItem(tabName = "data",
              h2("Data"),
              dataTableOutput("data_table")
      ),
      
      # About Page
      tabItem(tabName = "about",
              includeHTML("about.html")
      )
    )
  )
)
