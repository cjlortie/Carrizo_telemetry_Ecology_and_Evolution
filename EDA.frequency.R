#count by two levels for frequency
#counts <-data %>% group_by(mesohabitat, microhabitat.simple, behavior) %>% summarise(n=n())
#counts

#mesohabitat
#without simulated p-value
#c1<-chisq.test(counts$mesohabitat, counts$n)
#c1

#with simulated p-value
#c2<-chisq.test(counts$mesohabitat, counts$n, simulate.p.value = TRUE, B = 10000)
#c2

#Fisher's exact test for count data without simulated p-value
#fisher.test(counts$mesohabitat, counts$n)
#fisher.test(counts$mesohabitat, counts$n, simulate.p.value = TRUE, B = 10000)

#microhabitats
#c3<-chisq.test(counts$microhabitat.simple, counts$n)
#c3

#with simulated p-value
#c4<-chisq.test(counts$microhabitat.simple, counts$n, simulate.p.value = TRUE, B = 10000)
#c4

#behavior
#c5 <-chisq.test(counts$behavior, counts$n)
#c5

#c6 <-chisq.test(counts$behavior, counts$n, simulate.p.value = TRUE, B = 10000)
#c6


#Problem, we have two types of counts so testing each at once, like plotting one without the other does not make sense. So, can do a better model
#m1 <- glm(n~mesohabitat*microhabitat.simple, family = "poisson", data = counts)
#summary(m1)
#anova(m1, test = "Chisq")

#but is the best way to model mesohabitat by microhabitat as interaction terms? Not fully independent
#m2 <- glm(n~mesohabitat/microhabitat.simple, family = "poisson", data = counts)
#summary(m2)
#anova(m2, test = "Chisq")

#mixed model with random effect
#library(lme4)
#m3 <- lmer(n~mesohabitat + (1 | microhabitat.simple), data = counts)
#summary(m3)
#anova(m3, test = "Chisq")
#AIC(m2,m3)
#best model is nested model

#repeat by sex and AM/PM
#consider testing behavior too

#FINAL Model
#require(lmerTest)
#m <- lmer(observations~mesohabitat*behavior + (1 | microhabitat.simple), data = data)
#summary(m)
#anova(m, test = "Chisq")