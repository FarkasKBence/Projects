# Simulate 1000 dice throws and calculate the average roll value

# Set seed for reproducibility
set.seed(1)

# Number of throws
num_throws <- 1000

# Validate input
if (!is.numeric(num_throws) || num_throws <= 0 || num_throws != as.integer(num_throws)) {
  stop("Number of throws must be a positive integer.")
}

# Simulate dice throws (values from 1 to 6)
dice_rolls <- sample(1:6, size = num_throws, replace = TRUE)

# Calculate average roll value
average_roll <- mean(dice_rolls)

# Output results
cat("Number of throws:", num_throws, "\n")
cat("Average value rolled:", round(average_roll, 2), "\n")