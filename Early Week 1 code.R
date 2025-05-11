library(tidyverse)
library(lubridate)
library(readr)
library(dplyr)

# Load datasets
apple <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/Apple.csv")
microsoft <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/Microsoft.csv")
nvidia <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/Nvidia.csv")
google <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/Alphabet (Google).csv")

# Filter from 2004 to 2023
apple <- apple %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d")) %>%
  filter(year(Date) >= 2004 & year(Date) <= 2023)

microsoft <- microsoft %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y")) %>%
  filter(year(Date) >= 2004 & year(Date) <= 2023)

nvidia <- nvidia %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d")) %>%
  filter(year(Date) >= 2004 & year(Date) <= 2023)
  
google <- google %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d")) %>%
  filter(year(Date) >= 2004 & year(Date) <= 2023)

# View first 10 rows
head(apple, 10)
head(microsoft, 10)
head(nvidia, 10)
head(google, 10)

# Calculate daily returns
apple <- apple %>% arrange(Date) %>% mutate(Return = Close / lag(Close) - 1)
microsoft <- microsoft %>% arrange(Date) %>% mutate(Return = Close / lag(Close) - 1)
nvidia <- nvidia %>% arrange(Date) %>% mutate(Return = Close / lag(Close) - 1)
google <- google %>% arrange(Date) %>% mutate(Return = Close / lag(Close) - 1)

apple <- apple %>%
  arrange(Date) %>%
  mutate(Return = .data[["Close"]] / lag(.data[["Close"]]) - 1)
 
microsoft <- microsoft %>%
  arrange(Date) %>%
  mutate(Return = .data[["Close"]] / lag(.data[["Close"]]) - 1)
  
nvidia <- nvidia %>%
  arrange(Date) %>%
  mutate(Return = .data[["Close"]] / lag(.data[["Close"]]) - 1)
  
google <- google %>%
  arrange(Date) %>%
  mutate(Return = .data[["Close"]] / lag(.data[["Close"]]) - 1)


# Calculate standard deviation of daily returns
apple_sd <- sd(apple$Return, na.rm = TRUE)
microsoft_sd <- sd(microsoft$Return, na.rm = TRUE)
nvidia_sd <- sd(nvidia$Return, na.rm = TRUE)
google_sd <- sd(google$Return, na.rm = TRUE)

apple_sd
microsoft_sd
nvidia_sd
google_sd

# Create a table for the standard deviation
tibble(
  Stock = c("Apple", "Microsoft", "Nvidia", "Google"),
  `Standard Deviation` = c(apple_sd, microsoft_sd, nvidia_sd, google_sd)
)

# Correlation matrix
apple_ret <- apple %>% select(Date, Apple = Return)
microsoft_ret <- microsoft %>% select(Date, Microsoft = Return)
nvidia_ret <- nvidia %>% select(Date, Nvidia = Return)
google_ret <- google %>% select(Date, Google = Return)

# Join all four by Date
returns_df <- reduce(
  list(apple_ret, microsoft_ret, nvidia_ret, google_ret),
  full_join,
  by = "Date"
) %>% drop_na()

# Correlation matrix
cor_matrix <- cor(returns_df %>% select(-Date))
print(cor_matrix)

# Make sure they are numeric vectors
microsoft_ret <- returns_df[["Microsoft"]]
nvidia_ret <- returns_df[["Nvidia"]]
google_ret <- returns_df[["Google"]]
market <- returns_df[["Apple"]]

# Beta = Covariance(stock, market) / Variance(market)
beta_microsoft <- cov(microsoft_ret, market) / var(market)
beta_nvidia    <- cov(nvidia_ret, market) / var(market)
beta_google    <- cov(google_ret, market) / var(market)

# Display beta values
tibble(
  Stock = c("Microsoft", "Nvidia", "Google"),
  `Beta (vs Apple)` = c(beta_microsoft, beta_nvidia, beta_google)
)

# Combining into risk sumary table
risk_summary <- tibble(
  Stock = c("apple", "microsoft", "nvidia", "google"),
  `Standard Deviation` = c(apple_sd, microsoft_sd, nvidia_sd, google_sd),
  `Beta (vs Apple)` = c(1.0, beta_microsoft, beta_nvidia, beta_google)
)

print(risk_summary)