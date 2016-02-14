
library("markdown")

shinyUI(fluidPage(style="padding-top: 5px;",
  headerPanel("Titanic - Prediction of Survival"),
  
  #fixedPanel(
   # top = 10, bottom = 10
   # tags$h5("This app predicites whether you would have survived the disaster based on your gender, age and ticket booked on the Titanic")
  #),
  
  
  sidebarPanel(
    #top = '500px', bottom = 0, right = 0, left = 0,
    tags$h5("Please choose a gender, age and ticket (class):"),
    
    selectInput(inputId="text1", label = "Gender"
        , selected = FALSE, multiple = FALSE
        , choices = c("", "femal", "male")),
    selectInput(inputId="text3", label = "Age"
                , selected = NULL, choices = c("", "child", "adult")),
    selectInput(inputId="text2", label = "Class"
                , selected = NULL, choices = c("", "1st", "2nd", "3rd", "crew")),
    actionButton("goButton", "Go!")
  ),
  mainPanel(
    tags$h4("This app predicites whether you would have survived the disaster of the Titanic based on your gender, age and ticket booked on the Titanic"),
    br('Your gender: '),
    textOutput('text1'),
    br('Your age: '),
    textOutput('text3'),
    br('Your class: '),
    textOutput('text2'),
    #br('Your input:'),
    #textOutput('text4')
    p(''),
    textOutput('text5'),
    tags$head(tags$style("#text5{color: red;
                                 font-size: 20px;
                         font-style: italic;
                         }"
                         )
    )
  )
 
))