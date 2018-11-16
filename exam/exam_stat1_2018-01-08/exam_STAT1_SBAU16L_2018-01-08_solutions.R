library(knitr)

## Solutions exam stat1 2018-01-22

## Question 4
#
# On effectue une analyse d'expression différentielle pour les 5000 gènes d'une
# bactérie au moyen de biopuces transcriptomiques, avec 3 répliques par condition
# (traité versus contrôle). Pour un gène donné, on observe un niveau moyen de 15
# pour les échantillons soumis au traitement, 5 pour les contrôles, avec un
# écart-type de 5 dans les deux groupes. Sur base de données publiées précédemment,
# on postule que les fluctuations d'expression de ce gène suivent une distribution
# approximativement normale pour chacun des deux groupes.

n1 <- 3
n2 <- 3

m1 <- 15
m2 <- 5

s1 <- 5
s2 <- 5

s1.est <- n1 / (n1-1) * s1
s2.est <- n2 / (n2-1) * s2

result <- t(data.frame(
  mean = c(m1, m2),
  sd = c(s1, s2),
  sd.est = c(s1.est, s2.est)
))
colnames(result) <- c("Traité", "Non traité")
kable(result)

(t <- (m1 - m2)/ sqrt((n1*s1^2 + n2*s2^2 ) / (n1+n2-2)* (1/n1 + 1/n2)))
(df <- n1 + n2 - 2)
(p<- 2*pt(q = abs(t), df = df, lower.tail = FALSE))

N <- 5000
(E <- p*N)
