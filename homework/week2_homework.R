# install.packages(c("coda","mvtnorm","dagitty")) 
# remotes::install_github("stan-dev/cmdstanr")
# devtools::install_github("rmcelreath/rethinking")

# values p is gonna take
p_grid <- seq.int(0,1,len=1000)
# prior
prob_p <- rep(1L,1000L)
prob_p <- dbeta(p_grid, 3L,1L)
# likelihood
prob_data <- dbinom(60, 90, prob = p_grid)
posterior <- proportions(prob_data * prob_p)

plot(p_grid)
plot(prob_p)
plot(prob_data)
plot(p_grid, posterior)

samples <- sample(p_grid, 1e4, prob = posterior, replace = TRUE)
w <- rbinom(1e4, size = 9, prob = samples)
summary(as.factor(w)) # number of samples that are water (not land)
rethinking::simplehist(w)
#beta binominal

# homework

# 1. Suppose the globe tossing data (Chapter 2) had turned out to be 4 water and 
#    11 land. Construct the posterior distribution, using grid approximation. 
#    Use the same flat prior as in the book.


# 2. Now suppose the data are 4 water and 2 land. Compute the posterior again, 
#    but this time use a prior that is zero below p = 0.5 and a constant above 
#    p = 0.5. This corresponds to prior information that a majority of the 
#    Earth’s surface is water.


# 3. For the posterior distribution from 2, compute 89% percentile and HPDI 
#    intervals. Compare the widths of these intervals. 
#    Which is wider? Why? 
#    If you had only the information in the interval, what might you 
#    misunderstand about the shape of the posterior distribution?


# 4. OPTIONAL CHALLENGE. 
#    Suppose there is bias in sampling so that Land is more likely than Water
#    to be recorded. Specifically, assume that 1-in-5 (20%) of samples are
#    accidentally recorded as "Water" instead as "Land". 
#    First, write a generative simulation of this sampling process.
#    Assuming the true proportion of Water is 0.70, what proportion does your 
#    simulation tend to produce instead?
#    Second, using a simulated sample of 20 tosses, compute the unbiased 
#    posterior distribution of the true proportion of water.

