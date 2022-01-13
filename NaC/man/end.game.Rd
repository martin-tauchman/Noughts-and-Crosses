\name{end.game}
\alias{end.game}
\title{
End game
}
\description{
The function changes a variable in the environment to indicate that a new game should begin.
}
\usage{
end.game()
}
\details{
The function changes the variable \code{n.new} to \code{TRUE}.
}
\value{
No value is returned. The function modifies the variable \code{n.new} in the environment.
}
\references{
}
\author{
Martin Tauchman, Czechia
}
\note{
}


\seealso{
\code{\link{NaC}}
}
\examples{
end.game()

## The function is currently defined as
function ()
{
    n.new <<- TRUE
  }
}
