# Megfigyelt értékek
x <- c(14.8, 12.2, 16.8, 11.1)

# Paraméterek
sigma <- 2            # ismert szórás
alpha <- 0.05
z <- qnorm(1 - alpha/2)  # 1.96

# a) 95%-os konfidenciaintervallum µ-re
xbar <- mean(x)
n <- length(x)

lower <- xbar - z * sigma / sqrt(n)
upper <- xbar + z * sigma / sqrt(n)

cat("95%-os konfidenciaintervallum µ-re:", lower, ";", upper, "\n")

# b) Szükséges mintanagyság, ha a CI hossza ≤ 1.6
# CI hossza = 2 * z * sigma / sqrt(n) ≤ 1.6
# Ebből n ≥ (2 * z * sigma / 1.6)^2

desired_length <- 1.6
n_required <- ceiling( (2 * z * sigma / desired_length)^2 )

cat("Szükséges mintanagyság:", n_required, "\n")