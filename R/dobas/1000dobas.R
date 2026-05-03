#Simulate 1000 dice throws in R

# Set seed for reproducibility (optional)
set.seed(1)

# Number of throws
n_throws <- 0

# Simulate dice throws: sample numbers 1 to 6 with equal probability
dice_results <- sample(1:6, size = n_throws, replace = TRUE)

# Display first few results
head(dice_results)

# Count frequency of each face
freq_table <- table(dice_results)

# Print frequency table
print(freq_table)

# Calculate relative frequencies (probabilities)
probabilities <- prop.table(freq_table)
print(probabilities)

# Plot the results
barplot(freq_table,
        main = paste("Results of", n_throws, "Dice Throws"),
        xlab = "Dice Face",
        ylab = "Frequency",
        col = "skyblue",
        border = "black")