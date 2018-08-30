library(shiny)
library(shinydashboard)
library(shinycssloaders)



# Define UI for dataset viewer app ----
ui <- dashboardPage(
  
  # App title ----
  dashboardHeader(title="scRNA-Seq Explorer"),
  
  # Sidebar layout with input and output definitions ----
  dashboardSidebar(width=300,
    # Sidebar panel for inputs ----
    #sidebarPanel(
      
      # Input: Text for providing a caption ----
      # Note: Changes made to the caption in the textInput control
      # are updated in the output area immediately as you type
     # textInput(inputId = "caption",
    #    label = "Caption:",
    #    value = "Data Summary"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
        label = "Choose a dataset:",
        choices = c("CoH Breast Cancer", "Chung Breast Cancer", "Columbia GBM"),
        selected = NULL),
      
      # Input: Numeric entry for number of obs to view ----
      selectInput(inputId = "clustering",
        label = "Clustering Algorithm",
        choices = c("t-SNE", "PCA", "UMAP"),
        selected = NULL),
      
    selectInput(inputId = "genelist",
      label = "Gene List",
      choices = c("mcpCounter","LyonsEtAl","SchelkerEtAl","Wallet"),
      selected = NULL)
    
  ),
    # Main panel for displaying outputs ----
    dashboardBody(
      
      tags$h2("scRNA-Seq Visualization"),
      tags$hr(),
      tags$h4("To begin:"),
      tags$ol(),
      tags$li("\t1. Select a dataset"),
      tags$li("\t2. Select a visualization tool"),
      tags$li('\t3. Select a gene list'),
      tags$ol(),
      tags$hr(),
      tags$h5(textOutput('loaded')),
      tags$hr(),
      # Output: Verbatim text for data summary ----
      tags$h5("Dataset visualization"),
      plotOutput("plot"),
      tags$hr(),
      tags$h5("Gene List Visualization"),
    plotOutput("genes")
      # Output: HTML table with requested number of observations ----
     # tableOutput("view")
    )
)


server <- function(input, output) {
  require(singleCellSeq)
  
  changObject<-loadChang()
  simsObject<-loadSims()
  chungObject <- loadChung()
  
  # Return the requested dataset ----
  # By declaring datasetInput as a reactive expression we ensure
  # that:
  #
  # 1. It is only called when the inputs it depends on changes
  # 2. The computation and result are shared by all the callers,
  #    i.e. it only executes a single time
  datasetInput <- reactive({
    switch(input$dataset,
      "CoH Breast Cancer"=changObject,
      "Columbia GBM"=simsObject,
      "Chung Breast Cancer"=chungObject
    )
  })
  
  # Create caption ----
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  # 1. This function is automatically called to recompute the output
  # 2. New caption is pushed back to the browser for re-display
  #
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$caption, those expressions are
  # NOT called when input$caption changes
#  output$caption <- renderText({
#    paste("Data modeling of",input$dataset)
#  })
  
  
  output$loaded <-renderText({
    require(dplyr)
   # if(input$dataset!=""){
    alld<<-datasetInput()#%>% withSpinner(color="#0dc5c1")
  #  dataset <<- alld$data
    paste("Summary of the",input$dataset,'dataset')
    
  })
  # Generate a summary of the dataset ----
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated, i.e. whenever the input$dataset changes
  
  dataClustering <- reactive({
    doCluster(method=input$clustering,alld$seurat)
  
#    doCluster(method=input$clustering,clust.sres=switch(input$dataset,
#      "CoH Breast Cancer"=changObject$seurat,
#      "Columbia GBM"=simsObject$seurat,
#      "Chung Breast Cancer"=chungObject$seurat
#    ))
#    switch(input$clustering,
#      "CoH Breast Cancer"=loadChang(),
#      "Columbia GBM"=loadSims(),
#      "Chung Breast Cancer"=loadChung()
    
  })
  
  plotGeneList <-reactive({
    gl=getGeneList(method=tolower(gsub(" ","",input$genelist)))
  })
  
  output$plot <- renderPlot({
    dataClustering()#%>% withSpinner(color="#0dc5c1")
  })
  
  output$genes <-renderPlot({
    plotGeneList()
  })
  
  # Show the first "n" observations ----
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so it will be re-executed whenever
  # input$dataset or input$obs is changed
#  output$view <- renderTable({
#    head(datasetInput(), n = input$obs)
#  })
  
}

shinyApp(ui, server)
