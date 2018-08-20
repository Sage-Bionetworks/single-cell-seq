library(shiny)
library(shinydashboard)
library(shinycssloaders)


# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("scRNA-Seq Explorer"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
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
    mainPanel(
      
      # Output: Formatted text for caption ----
  #    h3(textOutput("caption", container = span)),
      h2("scRNA-Seq Visualization"),
      hr(),
      h4("To begin:"),
      p("\t1. Select a dataset"),
      p("\t2. Select a visualization tool"),
      p('\t3. Select a gene list'),
      hr(),
      h5(textOutput('loaded')),
      hr(),
      # Output: Verbatim text for data summary ----
      h5("Dataset visualization"),
      plotOutput("plot"),
      hr(),
      h5("Gene List Visualization"),
      plotOutput("genes")
      # Output: HTML table with requested number of observations ----
     # tableOutput("view")
      
    )
  )
)

server <- function(input, output) {
  require(singleCellSeq)
  
  # Return the requested dataset ----
  # By declaring datasetInput as a reactive expression we ensure
  # that:
  #
  # 1. It is only called when the inputs it depends on changes
  # 2. The computation and result are shared by all the callers,
  #    i.e. it only executes a single time
  datasetInput <- reactive({
    switch(input$dataset,
      "CoH Breast Cancer"=loadChang(),
      "Columbia GBM"=loadSims(),
      "Chung Breast Cancer"=loadChung()
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
    alld<-datasetInput()#%>% withSpinner(color="#0dc5c1")
    dataset <<- alld$data
    paste("Summary of the",input$dataset,'dataset')
    
  })
  # Generate a summary of the dataset ----
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated, i.e. whenever the input$dataset changes
  dataClustering <- reactive({
    doCluster(method=input$clustering,dataset)
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
