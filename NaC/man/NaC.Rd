\name{NaC}
\alias{NaC}
\title{Noughts and Crosses}
\description{
The function saves user's choice and generates the answer of the computer.
}
\usage{
NaC(field)
}
\arguments{
  \item{field}{
The field chosen by user. Use the function 'rules' for more details.
}
}
\details{
}
\value{
No value is returned. All of the outputs are saved in the special variables in the environment.
}
\author{
Martin Tauchman, Czechia
}
\note{
The function works with variables in the environment.
}
\seealso{
\code{\link{rules}}
\code{\link{end.game}}
}
\examples{
NaC(5)
NaC(1)
NaC(9)

## The function is currently defined as
function (field)
{
    if (!(exists("n.new"))) {
        n.new <<- TRUE
    }
    if (!(is.numeric(field))) {
        stop("Argument ?field? has to be a number. If you want to know more, type ?rules()? and press enter.")
    }
    if (!(field \%in\% 1:9)) {
        stop("Argument ?field? has to be a nummer from 1 to 9. If you want to know more, type ?rules()? and press enter.")
    }
    if (n.new) {
        desk <<- matrix("-", 3, 3)
        rows <<- matrix(0, 2, 3)
        columns <<- matrix(0, 2, 3)
        diagon <<- matrix(0, 2, 2)
    }
    if (!(is.free(field))) {
        stop("Selected field is not free. Choose another one.")
    }
    n.new <<- FALSE
    c.unplayed <- TRUE
    desk[convert(field)[1], convert(field)[2]] <<- "X"
    rows[1, convert(field)[1]] <<- rows[1, convert(field)[1]] +
        1
    columns[1, convert(field)[2]] <<- columns[1, convert(field)[2]] +
        1
    if ((field == 7) | (field == 5) | (field == 3)) {
        diagon[1, 1] <<- diagon[1, 1] + 1
    }
    if ((field == 1) | (field == 5) | (field == 9)) {
        diagon[1, 2] <<- diagon[1, 2] + 1
    }
    if ((3 \%in\% rows[1, ]) | (3 \%in\% columns[1, ]) | (3 \%in\%
        diagon[1, ])) {
        cat("You have won. Let's shake my mouse.\n")
        end.game()
        c.unplayed <- FALSE
    }
    if ((diagon[2, 1] == 2) & (diagon[1, 1] == 0) & c.unplayed) {
        s.diag <- c(desk[1, 1], desk[2, 2], desk[3, 3])
        free <- (1:3)[s.diag == "-"]
        c.unplayed <- FALSE
        writer(free, free)
        messenger(free, free)
    }
    if ((diagon[2, 2] == 2) & (diagon[1, 2] == 0) & c.unplayed) {
        s.diag <- c(desk[3, 1], desk[2, 2], desk[1, 3])
        free <- (1:3)[s.diag == "-"]
        if (free == 1) {
            coor <- 3
        }
        else {
            if (free == 2) {
                coor <- 2
            }
            else {
                coor <- 1
            }
        }
        c.unplayed <- FALSE
        writer(coor, free)
        messenger(coor, free)
    }
    for (i in 1:3) {
        if ((rows[2, i] == 2) & (rows[1, i] == 0) & c.unplayed) {
            s.row <- c(desk[i, 1], desk[i, 2], desk[i, 3])
            free <- (1:3)[s.row == "-"]
            c.unplayed <- FALSE
            writer(i, free)
            messenger(i, free)
        }
    }
    for (i in 1:3) {
        if ((columns[2, i] == 2) & (columns[1, i] == 0) & c.unplayed) {
            s.col <- c(desk[1, i], desk[2, i], desk[3, i])
            free <- (1:3)[s.col == "-"]
            c.unplayed = FALSE
            writer(free, i)
            messenger(free, i)
        }
    }
    if ((diagon[1, 1] == 2) & (diagon[2, 1] == 0) & c.unplayed) {
        s.diag <- c(desk[1, 1], desk[2, 2], desk[3, 3])
        free <- (1:3)[s.diag == "-"]
        c.unplayed <- FALSE
        writer(free, free)
        messenger(free, free)
    }
    if ((diagon[1, 2] == 2) & (diagon[2, 2] == 0) & c.unplayed) {
        s.diag <- c(desk[3, 1], desk[2, 2], desk[1, 3])
        free <- (1:3)[s.diag == "-"]
        if (free == 1) {
            coor <- 3
        }
        else {
            if (free == 2) {
                coor <- 2
            }
            else {
                coor <- 1
            }
        }
        c.unplayed <- FALSE
        writer(coor, free)
        messenger(coor, free)
    }
    for (i in 1:3) {
        if ((rows[1, i] == 2) & (rows[2, i] == 0) & c.unplayed) {
            s.row <- c(desk[i, 1], desk[i, 2], desk[i, 3])
            free <- (1:3)[s.row == "-"]
            c.unplayed <- FALSE
            writer(i, free)
            messenger(i, free)
        }
    }
    for (i in 1:3) {
        if ((columns[1, i] == 2) & (columns[2, i] == 0) & c.unplayed) {
            s.col <- c(desk[1, i], desk[2, i], desk[3, i])
            free <- (1:3)[s.col == "-"]
            c.unplayed = FALSE
            writer(free, i)
            messenger(free, i)
        }
    }
    if ((desk[2, 1] == "X") & (desk[3, 2] == "X") & is.free(1) &
        c.unplayed) {
        c.unplayed <- FALSE
        writer(3, 1)
        messenger(3, 1)
    }
    if ((desk[2, 1] == "X") & (desk[1, 2] == "X") & is.free(7) &
        c.unplayed) {
        c.unplayed <- FALSE
        writer(1, 1)
        messenger(1, 1)
    }
    if ((field == 1) & is.free(9) & c.unplayed) {
        c.unplayed <- FALSE
        writer(1, 3)
        messenger(1, 3)
    }
    if ((field == 3) & is.free(7) & c.unplayed) {
        c.unplayed <- FALSE
        writer(1, 1)
        messenger(1, 1)
    }
    if ((field == 7) & is.free(3) & c.unplayed) {
        c.unplayed <- FALSE
        writer(3, 3)
        messenger(3, 3)
    }
    if ((field == 9) & is.free(1) & c.unplayed) {
        c.unplayed <- FALSE
        writer(3, 1)
        messenger(3, 1)
    }
    for (i in c(5, sample(c(1, 3, 7, 9)), sample(c(2, 4, 6, 8)))) {
        if (is.free(i) & c.unplayed) {
            c.unplayed <- FALSE
            writer(convert(i)[1], convert(i)[2])
            messenger(convert(i)[1], convert(i)[2])
        }
    }
    if (((3 \%in\% rows[2, ]) | (3 \%in\% columns[2, ]) | (3 \%in\%
        diagon[2, ])) & !(n.new)) {
        cat("I have beaten you. You have lost.\n")
        end.game()
    }
    if ((sum(rows) == 9) & !(n.new)) {
        cat("The game has ended in a tie.\n")
        end.game()
    }
    print(desk)
    if ((sum(rows) == 8) & !(n.new)) {
        for (i in 1:9) {
            if (is.free(i)) {
                cat("The field number", i, "has been selected automatically.\n")
                NaC(i)
            }
        }
    }
    if (sum(rows) != sum(columns)) {
        warning("Manipulation in the code! Sums of rows and columns should be equal.")
    }
    if (sum(rows[1, ]) != sum(columns[1, ])) {
        warning("Manipulation in the code! Sums of the first rows in 'rows' and 'columns' should be equal.")
    }
    if (sum(rows[2, ]) != sum(columns[2, ])) {
        warning("Manipulation in the code! Sums of the second rows in 'rows' and 'columns' should be equal.")
    }
  }
}
