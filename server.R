shinyServer(
  function(input, output) {
    
    # load neural net library
    if (!require("neuralnet")) install.packages("neuralnet")
    library("neuralnet")
    
    # Load neural net:
    Titanic_nn <- readRDS("Titanic_nn.rds")
    
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({input$text3})
    output$text4 <- renderText({
      input$goButton
      isolate(paste(input$text1, ",", input$text2, ",", input$text3))
    })
    output$text5 <- renderText({
      if (input$goButton == 0) "Please select gender, class and age"
      else if (input$goButton > 0 && input$text1 != ''
               && input$text2 != '' && input$text3 != '') {
        x <- input$text1 
        gender <- c(0,0)
        if(x == "femal") { gender <- data.frame(0,1) }
        if(x == "male") { gender <- data.frame(1,0) }
        
        
        y <- input$text2 
        class <- c(0,0,0,0)
        if(y == "1st") class <- data.frame(1,0,0,0)
        if(y == "2nd") class <- data.frame(0,1,0,0)
        if(y == "3rd") class <- data.frame(0,0,1,0)
        if(y == "crew") class <- data.frame(0,0,0,1)
        
        
        z <- input$text3
        age <- c(0,0)
        if(z == "child") age <- data.frame(1,0)
        if(z == "adult") age <- data.frame(0,1)
        
        #print(gender)
        #print(class)
        #print(age)
        
        
        # calculate survival chance on Titanic:
        nn_input <- data.frame(class, gender, age)
        nn_result <- compute(Titanic_nn, nn_input)
        survival <- round(nn_result$net.result)
        
        if (survival >= 1.6) {
          print("It's likely that you would have survived the Titanic :-)")
        }
        else if (survival > 1.4 && survival < 1.6) { 
          print("Your survival chance is about 50 : 50 :-| ")
        }
        else {
          print("It's likely that you would not have survived the Titanic :-/ ")
        }
      }
      else "Please select gender, class and age"
    })
  }
)