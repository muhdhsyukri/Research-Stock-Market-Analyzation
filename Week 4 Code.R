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


nasdaq <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/NASDAQ.csv") %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y")) %>%
  arrange(Date) %>%
  mutate(Return = Price / lag(Price) - 1)

sp500 <- read_csv("C:/Users/Admin/Desktop/Research - Summer 2025/S&P 500.csv") %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y")) %>%
  arrange(Date) %>%
  mutate(Return = Price / lag(Price) - 1)

returns_df <- reduce(
  list(apple %>% select(Date, Apple = Return),
       nasdaq %>% select(Date, Nasdaq = Return),
       sp500 %>% select(Date, SP500 = Return)),
  full_join, by = "Date"
) %>% drop_na()

beta_apple_nasdaq <- cov(returns_df$Apple, returns_df$Nasdaq) / var(returns_df$Nasdaq)
beta_apple_sp500  <- cov(returns_df$Apple, returns_df$SP500) / var(returns_df$SP500)

returns_df <- returns_df %>%
  left_join(microsoft %>% select(Date, Microsoft = Return), by = "Date") %>%
  left_join(nvidia %>% select(Date, Nvidia = Return), by = "Date") %>%
  left_join(google %>% select(Date, Google = Return), by = "Date") %>%
  drop_na()

beta_df <- tibble(
  Stock = c("Apple", "Microsoft", "Nvidia", "Google"),
  Beta_Nasdaq = c(
    cov(returns_df$Apple, returns_df$Nasdaq) / var(returns_df$Nasdaq),
    cov(returns_df$Microsoft, returns_df$Nasdaq) / var(returns_df$Nasdaq),
    cov(returns_df$Nvidia, returns_df$Nasdaq) / var(returns_df$Nasdaq),
    cov(returns_df$Google, returns_df$Nasdaq) / var(returns_df$Nasdaq)
  ),
  Beta_SP500 = c(
    cov(returns_df$Apple, returns_df$SP500) / var(returns_df$SP500),
    cov(returns_df$Microsoft, returns_df$SP500) / var(returns_df$SP500),
    cov(returns_df$Nvidia, returns_df$SP500) / var(returns_df$SP500),
    cov(returns_df$Google, returns_df$SP500) / var(returns_df$SP500)
  )
)
print(beta_df)

# Creating a CSV file for return value to use it to create a visualization using tableau

export_df <- returns_df %>% 
  select(Date, Apple, Microsoft, Nvidia, Google, Nasdaq, SP500)



##----------------------------------  WEEK 4 -----------------------------------


## Creating keyword dictionary
keyword_data <- tibble::tibble(
  Keyword = c(
    "efficacy", "response", "improvement", "advancement", "increase", "enhanced", 
    "survival", "regression", "development", "capital", "proceeds", "raise", 
    "warrants", "valuation", "liquidity", "investment", "growth", "volatility", 
    "confidence", "dilution"
  ),
  Article = c(
    rep("Past", 9), rep("Current", 11)
  ),
  Proof = c(
    "Efficacy signals were observed in patients receiving the immunotherapy...",
    "...elicited a potent immune response...",
    "...showed improved progression-free survival...",
    "Supports the continued advancement of IMNN-001 into Phase 2 trials.",
    "Increased infiltration of CD8+ T-cells...",
    "...enhanced antigen presentation capabilities in treated patients.",
    "Median progression-free survival improved in the treatment arm.",
    "Observed tumor regression in multiple subjects...",
    "...ongoing clinical development of our immunotherapy platform.",
    "...intends to use the net proceeds for working capital and general corporate purposes.",
    "Gross proceeds from the offering are expected to be approximately $3.25 million...",
    "Announces up to $9.75 million private placement...",
    "...includes short-term warrants exercisable immediately...",
    "Priced at-the-market under Nasdaq rules...",
    "This private placement provides immediate liquidity through upfront cash...",
    "Private placement implies external investment coming into the firm.",
    "Funding trials and expansion suggests growth potential.",
    "Trial and financing news often introduce market volatility.",
    "Investor confidence supported by positive trial data and funding.",
    "Private placement and warrants imply potential for dilution."
  )
)

# View the table
print(keyword_data)

# Simulate matching on a sample news article
sample_news <- "IMUNON secured $9.75 million in proceeds through a private placement to support the advancement of IMNN-001 after positive survival data."

# Find matched keywords
matched_keywords <- keyword_data 
  filter(str_detect(sample_news, regex(Keyword, ignore_case = TRUE)))

# Show matched terms
print(matched_keywords)