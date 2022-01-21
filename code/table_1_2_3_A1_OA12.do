
	***********************************************************
	**** TABLES 1, 2 and 3: SUMMARY STATS and MAIN RESULTS ****
	***********************************************************


	capture drop sample*
	capture est drop _all
	
	capture erase ".\results\table_2.csv"
	capture erase ".\results\table_3.csv"
	capture erase ".\results\table_A1.csv"
	
	
		*** TABLES 2 and 3 ***
	
		foreach n in TC {
				reghdfe rel_share ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_noECSP
					estfe regr_`n'_noECSP, labels(year_iso3code "Country-Year FE")
				reghdfe rel_share ${ECSP_`n'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_ECSP
					estfe regr_`n'_ECSP, labels(year_iso3code "Country-Year FE")
				
			foreach m in EPSI HLT {
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_`m'
					estfe regr_`n'_`m', labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					gen sample_`n'_`m' = 1 if e(sample)	
					est store regr_`n'_`m'_HOcontr
					estfe regr_`n'_`m'_HOcontr, labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'_HOcontr
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'_HOcontr
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'} ${disp} ${Antras_Chor} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou} ${credit_interact_nocou} ${labormarket_interact_nocou} ${interm_interact}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_`m'_HOconcrelab
					estfe regr_`n'_`m'_HOconcrelab, labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'_HOconcrelab
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'_HOconcrelab
				
				reghdfe rel_share  c.${ECSP_`n'}#c.${`m'} ${HO_interact_all_nocou_`n'} ${credit_interact_nocou} ${labormarket_interact_nocou} ${contract_interact_nocou} ${interm_interact}, absorb(year_iso3code year_ind)  vce(cluster i.IO2007_num)
					est store regr_`n'_`m'_indfe
					estfe regr_`n'_`m'_indfe, labels(year_iso3code "Country-Year FE" year_ind "Industry-Year FE")
				

				}
			}	
		
		esttab regr* using ".\results\table_2.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) order(waste* c.waste_int_ln_totalcost_2#*) ///
					keep(waste* c.waste_int_ln_totalcost_2#* ${AYcontrols_TC}) ///
					stats(N_clust r2_a N, fmt(a) labels("IO2007 Industry Clusters" "Adj. R2" "Observations")) /// 
					obslast starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) title("Dependent Variable: Intrafirm Import Share") ///
					mlabels(- - EPSI EPSI EPSI EPSI HLT HLT HLT HLT, lhs(Intensity Definition: Total Cost, Environmental Index:)) ///
					label interact(" X ") noomit indicate("Country X Industry Interactions = ${HO_interact_all_nocou_`n'} ${contract_interact_nocou}" ///
					"Dispersion, Antràs Chor (2013) = ${disp}" "Add. CA Controls, Intermediation + Interactions = ${interm_interact} ${credit_interact_nocou} ${labormarket_interact_nocou}" `r(indicate_fe)') 
		
		**keep(waste* c.waste_int_ln_totalcost_2#* randd_intensity_ln_AY skill_int_ln_totalcost_2 othermach_int_ln_totalcost_2 building_int_ln_totalcost_2 auto_int_ln_totalcost_2 computer_int_ln_totalcost_2 contractibility) ///
					
		
		esttab marg* using ".\results\table_3.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) ///
					noobs starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) label ///
					mlabels(EPSI EPSI EPSI HLT HLT HLT, lhs(ENVI:)) coeflabels(waste_int_ln_totalcost_2 "Percentile")
		
		
		
		
		*** TABLE A1 ***
		
		capture est drop _all
		
		foreach n in TC {
				reghdfe rel_share ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_noECSP
					estfe regr_`n'_noECSP, labels(year_iso3code "Country-Year FE")
				reghdfe rel_share ${ECSP_`n'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_ECSP
					estfe regr_`n'_ECSP, labels(year_iso3code "Country-Year FE")
				
			foreach m in EPSI HLT {
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_`m'
					estfe regr_`n'_`m', labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					*gen sample_`n'_`m' = 1 if e(sample)	
					est store regr_`n'_`m'_HOcontr
					estfe regr_`n'_`m'_HOcontr, labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'_HOcontr
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'_HOcontr
				
				reghdfe rel_share ${ECSP_`n'}  c.${ECSP_`n'}#c.${`m'} ${AYcontrols_`n'} ${disp} ${Antras_Chor} ${HO_interact_all_nocou_`n'} ${contract_interact_nocou} ${credit_interact_nocou} ${labormarket_interact_nocou} ${interm_interact}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`n'_`m'_HOconcrelab
					estfe regr_`n'_`m'_HOconcrelab, labels(year_iso3code "Country-Year FE")
					est restore regr_`n'_`m'_HOconcrelab
					margins, post dydx(${ECSP_`n'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`n'_`m'_HOconcrelab
				
				reghdfe rel_share  c.${ECSP_`n'}#c.${`m'} ${HO_interact_all_nocou_`n'} ${credit_interact_nocou} ${labormarket_interact_nocou} ${contract_interact_nocou} ${interm_interact}, absorb(year_iso3code year_ind)  vce(cluster i.IO2007_num)
					est store regr_`n'_`m'_indfe
					estfe regr_`n'_`m'_indfe, labels(year_iso3code "Country-Year FE" year_ind "Industry-Year FE")
				

				}
			}	
		
		esttab regr* using ".\results\table_A1.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) order(waste* c.waste_int_ln_totalcost_2#*) drop(0.sigma_median_dummy) /// 
					stats(N_clust r2_a N, fmt(a) labels("IO2007 Industry Clusters" "Adj. R2" "Observations")) /// 
					obslast starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) title("Dependent Variable: Intrafirm Import Share") ///
					mlabels(- - EPSI EPSI EPSI EPSI HLT HLT HLT HLT, lhs(Intensity Definition: Total Cost, Environmental Index:)) ///
					label interact(" X ") noomit indicate(`r(indicate_fe)') 
		

					
		
		

		*** TABLE 1 ***
		
			preserve
			
			gen waste_int_totalcost2 = exp(waste_int_ln_totalcost_2)
			keep waste_int_totalcost2 sample* IO2007*
			duplicates drop
			collapse (mean) waste_int_totalcost2 sample_TC_HLT, by(IO2007 IO2007_num)
			drop if sample_TC_HLT != 1
			drop sample* *_num
			sort waste_int_totalcost2
			gen waste_frombelow = _n
			gen waste_fromabove = _N - _n +1 
			keep if waste_frombelow <= 20 | waste_fromabove <= 20
			
			rename IO2007 io_input
			
			*merge with industry names
			merge 1:1 io_input using ".\data\IO2007_industrylist.dta"
			keep if _merge == 3
			
			rename io_input Industry
			rename io_input_name IO2007_name
			rename waste_int_totalcost2 ECSP
			drop _merge waste_from*
			order Industry IO*
			
			sort ECSP
			
			export excel using ".\results\table_1.xlsx", sheet("table_1") firstrow(variables) replace
			
			restore
			
		*** TABLE OA.12 ***
		
		preserve
		
		label var Env_String_Index "EPSI"
		label var HLT "HLT"
		
		mkcorr waste_int_ln_totalcost_2 lus_randd_intensity_0005_AC2013 skill_int_ln_totalcost_2 othermach_int_ln_totalcost_2 building_int_ln_totalcost_2 auto_int_ln_totalcost_2 ///
			computer_int_ln_totalcost_2 contractibility disp1_2005 sigma_median_dummy DUse_TUse Env_String_Index HLT skill_ab_ln cap_ab_ln ruleoflaw if sample_TC_HLT == 1, log(".\results\table_OA12.xls") replace lab cdec(4) sig
		
		restore

		