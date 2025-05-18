library(tidyverse)
library(lubridate)
library(readr)
library(dplyr)

## ------------------------------ Week 1 ---------------------------------------

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

apple <- apple %>% select(Date, Close, Volume, Return)
microsoft <- microsoft %>% select(Date, Close, Volume, Return)
nvidia <- nvidia %>% select(Date, Close, Volume, Return)
google <- google %>% select(Date, Close, Volume, Return)


--------------------------------- ## Week 2 ------------------------------------

# Creating line graph for each 4 big tech companies for volume value in year 2022

Apple_2022 <- apple %>% filter(year(Date) == 2022)
ggplot(Apple_2022, aes(x = Date, y = Volume)) +
  geom_line() +
  ggtitle("Apple Daily Trading Volume in 2022")

Nvidia_2022 <- nvidia %>% filter(year(Date) == 2022)
ggplot(Nvidia_2022, aes(x = Date, y = Volume)) +
  geom_line() +
  ggtitle("Nvidia Daily Trading Volume in 2022")

Google_2022 <- google %>% filter(year(Date) == 2022)
ggplot(Google_2022, aes(x = Date, y = Volume)) +
  geom_line() +
  ggtitle("Google Daily Trading Volume in 2022")

Microsoft_2022 <- microsoft %>% filter(year(Date) == 2022)
ggplot(Microsoft_2022, aes(x = Date, y = Volume)) +
  geom_line() +
  ggtitle("Microsoft Daily Trading Volume in 2022")


avg_volume <- tibble(
  Company = c("Apple", "Microsoft", "Nvidia", "Google"),
  Avg_Volume = c(mean(Apple_2022$Volume),
                 mean(Microsoft_2022$Volume),
                 mean(Nvidia_2022$Volume),
                 mean(Google_2022$Volume))
)

ggplot(avg_volume, aes(x = Company, y = Avg_Volume, fill = Company)) +
  geom_bar(stat = "identity") +
  ggtitle("Average Daily Volume in 2022")

# Top 10 volume spikes value for each companies to identify which year produce the highest value of the volume in the stock market. 

top_volume_apple <- apple %>% arrange(desc(Volume)) %>% slice_head(n = 10)
top_volume_microsoft <- microsoft %>% arrange(desc(Volume)) %>% slice_head(n = 10)
top_volume_nvidia <- nvidia %>% arrange(desc(Volume)) %>% slice_head(n = 10)
top_volume_google <- google %>% arrange(desc(Volume)) %>% slice_head(n = 10)

# Lowest 10 volume spikes value for each company

lowest_volume_apple <- apple %>% arrange(Volume) %>% slice_head(n = 10)
lowest_volume_microsoft <- microsoft %>% arrange(Volume) %>% slice_head(n = 10)
lowest_volume_google <- google %>% arrange(Volume) %>% slice_head(n = 10)
lowest_volume_nvidia <- nvidia %>% arrange(Volume) %>% slice_head(n = 10)

# Created 4 csv files to keep track all 4 of the highest 10 volume in 4 companies

write_csv(top_volume_apple, "top_volume_apple.csv")
write_csv(top_volume_microsoft, "top_volume_microsoft.csv")
write_csv(top_volume_nvidia, "top_volume_nvidia.csv")
write_csv(top_volume_google, "top_volume_google.csv")

# Im just using this to locate where the file was saved
getwd()

# Calculating daily percent change in in total volume and add the extra column in the existing table.

# Apple company
apple <- apple %>%
  arrange(Date) %>%
  mutate(Volume_Change = (Volume / lag(Volume)) - 1)

# Microsoft company
microsoft <- microsoft %>%
  arrange(Date) %>%
  mutate(Volume_Change = (Volume / lag(Volume)) - 1)

# Nvidia company
nvidia <- nvidia %>%
  arrange(Date) %>%
  mutate(Volume_Change = (Volume / lag(Volume)) - 1)

# Google company
google <- google %>%
  arrange(Date) %>%
  mutate(Volume_Change = (Volume / lag(Volume)) - 1)

apple %>% arrange(desc(Volume_Change)) %>% slice_head(n = 10)
microsoft %>% arrange(desc(Volume_Change)) %>% slice_head(n = 10)
nvidia %>% arrange(desc(Volume_Change)) %>% slice_head(n = 10)
google %>% arrange(desc(Volume_Change)) %>% slice_head(n = 10)

#  Compare Volume Spikes with Daily Returns

volume_return_apple <- apple %>%
  arrange(desc(Volume)) %>%
  slice_head(n = 10) %>%
  select(Date, Volume, Return)

volume_return_microsoft <- microsoft %>%
  arrange(desc(Volume)) %>%
  slice_head(n = 10) %>%
  select(Date, Volume, Return)

volume_return_nvidia <- nvidia %>%
  arrange(desc(Volume)) %>%
  slice_head(n = 10) %>%
  select(Date, Volume, Return)

volume_return_google <- google %>%
  arrange(desc(Volume)) %>%
  slice_head(n = 10) %>%
  select(Date, Volume, Return)


## ------------------------------- Week 3 --------------------------------------

