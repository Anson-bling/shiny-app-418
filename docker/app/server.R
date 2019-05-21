#
# This ShinyApp shows how to evaluate and compare
# the quality of linear models.
#

library(shiny)

shinyServer(function(input, output) {
  
  # Reactive value that triggers plot update and stores fitted values
  v <- reactiveValues(fitted_values = NULL,
                      r2 = NULL)

  # When action button was triggered...
  observeEvent(input$trigger_estimation, {
    # Add progress bar
    withProgress(message = 'Please wait',
                 detail = 'Run estimation...', value = 0.6,
    {
      # Run estimation depending on the model specification
      if (input$model == "2"){
        estimation <- kmeans(data_helper$clust,2)
      }
      else if (input$model == "3"){
        estimation <- kmeans(data_helper$clust,3)
      }
      else if (input$model == "4"){
        estimation <- kmeans(data_helper$clust,4)
      }
      else {
        estimation <- kmeans(data_helper$clust,5)
      }
      
      # Increase progress bar to 0.8  
      incProgress(0.8, detail="Store results")
      
      v$var <- round(estimation$betweenss/estimation$totss*100,2)
      v$centers <- estimation$centers
      v$clusters <- estimation$cluster
      
      # Increase progress bar to 1
      incProgress(1, detail="Finish")
    })
  })
  
  # Estimation Results
  output$estimation_results <- renderText(
    v$var
  )
  
  # Accuracy Box
  output$accuracy_box <- renderValueBox({
    valueBox(
      paste0(v$var, "%"), "% of Variance Explained", icon = icon("tachometer"),
      color = "light-blue"
      )	
    })
  
  # Overview Plot
  output$plot <- renderPlot({
      plot(data_helper$clust[,c("Sepal.Length", "Sepal.Width")], col = v$clusters,
           main = "Iris plot of Sepal Length and Width Colored by Cluster",
           xlab = "Sepal Length",
           ylab = "Sepal Width")
      points(v$centers[,c("Sepal.Length", "Sepal.Width")],
            col = 1:5,
            pch = 20,
            cex = 2
            )
    
  })
  #could add screeplot right here

  # Show Data Table
  output$data_table <- renderDataTable(data)

})
