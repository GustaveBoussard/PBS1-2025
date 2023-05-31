n <- 50
nobs <- 4000
lesXb <- data.frame(xb <- rep(0, nobs), z <- rep(0, nobs))
lesXb$xb <- replicate(nobs, mean(rbinom(n, size = 5, p = 0.3)))
lesXb$z <- (lesXb$xb - mean(lesXb$xb)) / sd(lesXb$xb)
library(ggplot2)
library(cowplot)
densityNorm = data.frame(x = seq(length = 100, from = -2, to = 2))
densityNorm$y = dnorm(densityNorm$x)
ggplot(lesXb)+ 
  aes(x = z) + 
  geom_histogram(color = "black", 
                 fill = "white", 
                 aes(y= ..density..), 
                 bins = 15) + 
  xlab("Z") + 
  ylab("Histogramme Z") +
  geom_line(data = densityNorm,
            aes(x = x, y = y),
            color = "red")

