library(metafolio)

vignette("metafolio") 
?metafolio 
help(package= "metafolio")

arma_env_params <- list(mean_value = 16, ar = 0.1, sigma_env = 2,
                        ma = 0)
base1<-meta_sim(n_pop= 10,env_params =arma_env_params, env_type= "arma",assess_freq =5)
plot_sim_ts(base1,years_to_show =70, burn= 30)

  
w_plans<-list() 
w_plans[["balanced"]]<-c(5,1000, 5,1000, 5,5, 1000,5, 1000,5) 
w_plans[["one_half"]]<-c(rep(1000,4), rep(5,6)) 
w <-list() 

for(i in 1:2) { #loopoverplans 
  w[[i]]<-list() 
for(j in 1:80) 
    { #loopoveriterations 
w[[i]][[j]]<-matrix(w_plans[[i]],nrow =1) 
} 
  }

set.seed(1) 
arma_sp<-run_cons_plans(w,env_type ="arma", env_params= arma_env_params) 
plot_cons_plans(arma_sp$plans_mv, plans_name= c("Balanced","One half"), cols =c("#E41A1C","#377EB8"), xlab= "Varianceof growthrate", ylab ="Mean growth rate")


types<-c("sine","arma", "regime","linear", "constant") 
x <-list() 
for(i in 1:5) x[[i]] <-generate_env_ts(n_t =100, type= types[i]) 
par(mfrow= c(5, 1), mar = c(3,3,1,0), cex= 0.7) 
for(i in 1:5) plot(x[[i]], type= "o", main = types[i])

plot_rickers(base1,pal =rep("black", 10))

plot_correlation_between_returns(base1)

set.seed(1) 
weights_matrix<-create_asset_weights(n_pop = 6,n_sims =3000, weight_lower_limit= 0.001) 
mc_ports<-monte_carlo_portfolios(weights_matrix = weights_matrix, n_sims= 3000, mean_b = 1000)
col_pal<-rev(gg_color_hue(6)) 
ef_dat <-plot_efficient_portfolios(port_vals = mc_ports$port_vals, pal =col_pal, weights_matrix =weights_matrix)
