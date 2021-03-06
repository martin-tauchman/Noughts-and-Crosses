#noughts and crosses
# Help with rules
rules <- function() {
  cat("Welcome to the game Noughts and Crosses\nYour task is to have three crosses in a row, a column or a diagonal.\n")
  cat("You can add a cross using the function NaC. In the argument use the number of the selected field (see below).\n")
  print(matrix(c(7:9,4:6,1:3),3,3,b=T))
  cat("The computer will make its choice automatically and decide if there is a winner.\n")
  cat("If there is no winner, use the function NaC again.\n")
  cat("If you want to end the current game, use the function end.game.\n")
  cat("If you want to quit R, use the function q.\n")
  cat("Enjoy the game.\n")
  cat("Made by Martin Tauchman, student at the Faculty of Science, Charles University, Prague, Czechia")
}

end.game <- function() {n.new <<- TRUE}

# Converting given number of field to the coordinates of the field
convert <- function(field) {
  if(field %in% 7:9) {
    return(c(1, field - 6))
  }else{
    if(field %in% 4:6) {
      return(c(2, field - 3))
    }else{
      return(c(3, field))
    }
  }
}

# Investigating if the given field is free
is.free <- function(field = field, i.desk = desk) {
  coordinates <- convert(field)
  if(i.desk[coordinates[1], coordinates[2]] == "-") {return(TRUE)}else{return(FALSE)}
}

# Writing computer response to the corresponding variables
writer <- function(r, c) { #The function writes the computer's choice in the computer. r for rows, c for columns
  desk[r, c] <<- "O"
  rows[2, r] <<- rows[2, r] + 1
  columns[2, c] <<- columns[2, c] + 1
  if(r == c) {diagon[2, 1] <<- diagon[2, 1] + 1}
  if(((r == 3) & (c == 1)) | ((r == 2) & (c == 2)) | ((r == 1) & (c == 3))) {diagon[2, 2] <<- diagon[2, 2] + 1}
}

# Writing a message about the field, chosen by the computer
messenger <- function(r, c) {
  if(r == 1) {
    if(c == 1) {field <- 7}
    if(c == 2) {field <- 8}
    if(c == 3) {field <- 9}
  }
  if(r == 2) {
    if(c == 1) {field <- 4}
    if(c == 2) {field <- 5}
    if(c == 3) {field <- 6}
  }
  if(r == 3) {
    field <- c
  }
  cat(paste("I have chosen the field ", field, ".\n", sep = ""))
}

#The Main Function
NaC <- function(field) {
  if(!(exists("n.new"))) {n.new <<- TRUE}
  # Error messages and new desk creation
  if(!(is.numeric(field))) {stop("Argument ‘field’ has to be a number. If you want to know more, type ‘rules()’ and press enter.")}
  if(!(field %in% 1:9)) {stop("Argument ‘field’ has to be a number from 1 to 9. If you want to know more, type ‘rules()’ and press enter.")}
  if(n.new) {desk <<- matrix("-", 3, 3); rows <<- matrix(0, 2, 3); columns <<- matrix(0, 2, 3); diagon <<- matrix(0, 2, 2)}
  if(!(is.free(field))) {stop("Selected field is not free. Choose another one.")}
  # Changing indicator variables
  n.new <<- FALSE # It avoids generating a new desk and clearing variables.
  c.unplayed <- TRUE # It avoids multiple choices of the computer.
  # Recording user's choice
  desk[convert(field)[1], convert(field)[2]] <<- "X"
  rows[1, convert(field)[1]] <<- rows[1, convert(field)[1]] + 1
  columns[1, convert(field)[2]] <<- columns[1, convert(field)[2]] + 1
  if((field == 7) | (field == 5) | (field == 3)) {diagon[1, 1] <<- diagon[1, 1] + 1}
  if((field == 1) | (field == 5) | (field == 9)) {diagon[1, 2] <<- diagon[1, 2] + 1}
  if((3 %in% rows[1,]) | (3 %in% columns[1, ]) | (3 %in% diagon[1, ])) {cat("You have won. Let's shake my mouse.\n"); end.game(); c.unplayed <- FALSE} #Investigates if the human has won
  # Answer of the computer
  ## One step to win
  if((diagon[2, 1] == 2) & (diagon[1, 1] == 0) & c.unplayed) {
    s.diag <- c(desk[1, 1], desk[2, 2], desk[3, 3])
    free <- (1:3)[s.diag == "-"]
    c.unplayed <- FALSE
    writer(free, free)
    messenger(free, free)
  }
  if((diagon[2, 2] == 2) & (diagon[1, 2] == 0) & c.unplayed) {
    s.diag <- c(desk[3,1], desk[2,2], desk[1, 3])
    free <- (1:3)[s.diag == "-"]
    if(free == 1) {coor <- 3}else{if(free == 2) {coor <- 2}else{coor <- 1}}
    c.unplayed <- FALSE
    writer(coor, free)
    messenger(coor, free)
  }
  for (i in 1:3) {
    if((rows[2, i] == 2) & (rows[1, i] == 0) & c.unplayed) {
      s.row <- c(desk[i, 1], desk[i, 2], desk[i, 3])
      free <- (1:3)[s.row == "-"]
      c.unplayed <- FALSE
      writer(i, free)
      messenger(i, free)
    }
  }
  for (i in 1:3) {
    if((columns[2, i] == 2) & (columns[1, i] == 0) & c.unplayed){
      s.col <- c(desk[1, i], desk[2, i], desk[3, i])
      free <- (1:3)[s.col == "-"]
      c.unplayed = FALSE
      writer(free, i)
      messenger(free, i)
    }
  }
  ## One step to lose
  if((diagon[1, 1] == 2) & (diagon[2, 1] == 0) & c.unplayed) {
    s.diag <- c(desk[1, 1], desk[2, 2], desk[3, 3])
    free <- (1:3)[s.diag == "-"]
    c.unplayed <- FALSE
    writer(free, free)
    messenger(free, free)
  }
  if((diagon[1, 2] == 2) & (diagon[2, 2] == 0) & c.unplayed) {
    s.diag <- c(desk[3,1], desk[2,2], desk[1, 3])
    free <- (1:3)[s.diag == "-"]
    if(free == 1) {coor <- 3}else{if(free == 2) {coor <- 2}else{coor <- 1}}
    c.unplayed <- FALSE
    writer(coor, free)
    messenger(coor, free)
  }
  for (i in 1:3) {
  if((rows[1, i] == 2) & (rows[2, i] == 0) & c.unplayed) {
    s.row <- c(desk[i, 1], desk[i, 2], desk[i, 3])
    free <- (1:3)[s.row == "-"]
    c.unplayed <- FALSE
    writer(i, free)
    messenger(i, free)
    }
  }
  for (i in 1:3) {
    if((columns[1, i] == 2) & (columns[2, i] == 0) & c.unplayed){
      s.col <- c(desk[1, i], desk[2, i], desk[3, i])
      free <- (1:3)[s.col == "-"]
      c.unplayed = FALSE
      writer(free, i)
      messenger(free, i)
    }
  }
  ## Dealing with the fact there is no one-step way to win and no one-step way to lose
  ### Avoiding forks
  if((desk[2, 1] == "X") & (desk[3, 2] == "X") & is.free(1) & c.unplayed) {
    c.unplayed <- FALSE
    writer(3, 1)
    messenger(3, 1)
  }
  if((desk[2, 1] == "X") & (desk[1, 2] == "X") & is.free(7) & c.unplayed) {
    c.unplayed <- FALSE
    writer(1, 1)
    messenger(1, 1)
  }
  ### Placing in the opossite corner
  if((field == 1) & is.free(9) & c.unplayed) {
    c.unplayed <- FALSE
    writer(1, 3)
    messenger(1, 3)
  }
  if((field == 3) & is.free(7) & c.unplayed) {
    c.unplayed <- FALSE
    writer(1, 1)
    messenger(1, 1)
  }
  if((field == 7) & is.free(3) & c.unplayed) {
    c.unplayed <- FALSE
    writer(3, 3)
    messenger(3, 3)
  }
  if((field == 9) & is.free(1) & c.unplayed) {
    c.unplayed <- FALSE
    writer(3, 1)
    messenger(3, 1)
  }
  ### Giving random choice
  for (i in c(5, sample(c(1, 3, 7, 9)), sample(c(2, 4, 6, 8)))) {
   if(is.free(i) & c.unplayed){
     c.unplayed <- FALSE
     writer(convert(i)[1], convert(i)[2])
     messenger(convert(i)[1], convert(i)[2])
   }
  }
  if(((3 %in% rows[2, ]) | (3 %in% columns[2, ]) | (3 %in% diagon[2, ])) & !(n.new)) {cat("I have beaten you. You have lost.\n"); end.game()} #Investigates if the computer has won
  if((sum(rows) == 9) & !(n.new)) {cat("The game has ended in a tie.\n"); end.game()}
  print(desk)
  # Last automatic choice of the human player
 if((sum(rows) == 8) & !(n.new)) {
    for(i in 1:9) {
      if(is.free(i)) {cat("The field number", i, "has been selected automatically.\n");NaC(i)}
    }
 }
 # Manipulation in the code finding
 if(sum(rows) != sum(columns)) {warning("Manipulation in the code! Sums of rows and columns should be equal.")}
 if(sum(rows[1, ]) != sum(columns[1, ])) {warning("Manipulation in the code! Sums of the first rows in ‘rows’ and ‘columns’ should be equal.")}
 if(sum(rows[2, ]) != sum(columns[2, ])) {warning("Manipulation in the code! Sums of the second rows in ‘rows’ and ‘columns’ should be equal.")}
}
