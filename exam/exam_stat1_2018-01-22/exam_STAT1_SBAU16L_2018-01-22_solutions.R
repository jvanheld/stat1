library(knitr)

## Solution exam stat1 2018-01-22

x1 <- c(92,  96, 102,  86, 118, 110,  94, 102)
x2 <- c(125,  86,  76, 101,  95, 136, 108, 113)

n1 <- length(x1)
n2 <- length(x2)

m1 <- mean(x1)
m2 <- mean(x2)

v1 <- sum(x1^2)/n1 - m1^2
v2 <- sum(x2^2)/n2 - m2^2

s1 <- sqrt(v1)
s2 <- sqrt(v2)

v1.est <- v1*(n1/(n1-1))
v2.est <- v2*(n2/(n2-1))

s1.est <- sqrt(v1.est)
s2.est <- sqrt(v2.est)

result <- t(data.frame(
  mean = c(m1, m2),
  sd = c(s1, s2),
  sd.est = c(s1.est, s2.est),
  Q1 = c(quantile(x1, probs = 0.25), quantile(x2, probs = 0.25)),
  median = c(median(x1), median(x2)),
  Q3 = c(quantile(x2, probs = 0.25), quantile(x2, probs = 0.75))
))
colnames(result) <- c("Traité", "Non traité")
kable(result)

(t <- (m1 - m2)/ sqrt(s1.est^2/n1 + s2.est^2/n2))
(df <- (s1^2/n1 + s2^2/n2)^2 / (s1^4 / (n1^2*(n1-1)) + s2^4 / (n2^2*(n2-1))))
(p<- 2*pt(q = abs(t), df = df, lower.tail = FALSE))

# (t.S <- (m1 - m2)/ sqrt((n1*s1.est^2 + n2*s2.est^2 ) / (n1+n2-2)* (1/n1 + 1/n2)))

## Run the t.test to check that it returns the same result as what we computed above
t.test(x1, x2, var.equal = FALSE)

