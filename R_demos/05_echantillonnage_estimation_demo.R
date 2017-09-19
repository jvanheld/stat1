################################################################
## Sampling and estimation

## Population parameters
N <- 1000000 ## Population size
mu <- 0
sigma <- 1

## Sample parameters
n <- 3 ## Sample size

## Generate random numbers according to a Gaussian distribution
X <- rnorm(n = N, mean = mu, sd = sigma)

range(X) ## Etendue: min et max
abs(range(X)) ## Valeurs absolues du min et max
max(abs(range(X))) ## Etendue max à gauche ou à droite
xlim <- ceiling(max(abs(range(X)))) ## Entier supérieur à cette valeur


## Draw a sample from the population
## Tirer un échantillon de la population
x <- sample(x = X, size=n, replace = FALSE)

x.bar <- mean(x) ## Sample mean, moyenne d'échantillon
x.bar.manual <- sum(x) / n

## Replicate the sampling
R <- 10000 ## Number of replicates

sample.means <- replicate(
  n = R,
  expr = mean(sample(x = X,
                     size = 64,
                     replace = FALSE)))

par(mfrow=c(2,1))

hist(X, main="Population",
     breaks = seq(from=-xlim, to=xlim, by=0.1))

hist(sample.means, main = "Distrib. of sample means",
     breaks=seq(from=-xlim, to=xlim, by=0.1))

mean(sample.means)
sd(sample.means)

par(mfrow=c(1,1))


