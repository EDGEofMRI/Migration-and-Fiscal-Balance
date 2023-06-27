encode countryname, gen(country_N)
encode region, gen(region_N)
drop if region_N==.
encode lendingtype, gen(lendingtype_N)
drop if lendingtype_N==.
mvdecode *, mv(0)
xtset country_N year
drop if year<1990
drop if year>2019  
drop if E01Y01M1_Fiscalbalance==.
drop if E02Y01E2_Migration==.
egen id = group(countrycode)
by country_N: gen count=_N
sum id count
drop if count<10
drop id 
drop count 
sort country_N
egen id = group(countrycode)
by country_N: gen count=_N


reg3(E01Y01M1_Fiscalbalance E03Y01C1_GDP E04Y01C2_InflationRate E05Y01C3_InvestmentRate E06Y01C4_SavingsRate X_PopulationT1564 X_PopulationT65up) (E02Y01E2_Migration E03Y01C1_GDP X_UnemploymentTILO X_PopulationT X_WageWorkerT) (E03Y01C1_GDP E02Y01E2_Migration X_Trade X_ExpenseGDP X_LaborT) (E04Y01C2_InflationRate E02Y01E2_Migration E06Y01C4_SavingsRate X_UnemploymentTILO X_RInterestRate X_Trade X_Import) (E05Y01C3_InvestmentRate E02Y01E2_Migration X_RInterestRate E03Y01C1_GDP X_Export) (E06Y01C4_SavingsRate E02Y01E2_Migration E04Y01C2_InflationRate X_RInterestRate X_RevenueExGrants),small

ssc install asdoc

outreg2 using HIGHandUPPER1.doc, replace

shellout using `"HIGHandUPPER1.doc"'

sum E01Y01M1_Fiscalbalance E03Y01C1_GDP E04Y01C2_InflationRate E05Y01C3_InvestmentRate E06Y01C4_SavingsRate X_PopulationT1564 X_PopulationT65up E02Y01E2_Migration E03Y01C1_GDP X_UnemploymentTILO X_PopulationT X_WageWorkerT E03Y01C1_GDP E02Y01E2_Migration X_Trade X_ExpenseGDP X_LaborT E04Y01C2_InflationRate E02Y01E2_Migration E06Y01C4_SavingsRate X_UnemploymentTILO X_RInterestRate X_Trade X_Import E05Y01C3_InvestmentRate E02Y01E2_Migration X_RInterestRate E03Y01C1_GDP X_Export E06Y01C4_SavingsRate E02Y01E2_Migration E04Y01C2_InflationRate X_RInterestRate X_RevenueExGrants

asdoc sum E01Y01M1_Fiscalbalance E02Y01E2_Migration E03Y01C1_GDP E04Y01C2_InflationRate E05Y01C3_InvestmentRate E06Y01C4_SavingsRate X_PopulationT1564 X_PopulationT65up,star(all) dec(2)

asdoc pwcorr E01Y01M1_Fiscalbalance E02Y01E2_Migration E03Y01C1_GDP E04Y01C2_InflationRate E05Y01C3_InvestmentRate E06Y01C4_SavingsRate X_PopulationT1564 X_PopulationT65up, star(all) dec(2)

ssc install checkreg3

checkreg3(E01Y01M1_Fiscalbalance E03Y01C1_GDP E04Y01C2_InflationRate E05Y01C3_InvestmentRate E06Y01C4_SavingsRate X_PopulationT1564 X_PopulationT65up) (E02Y01E2_Migration E03Y01C1_GDP X_UnemploymentTILO X_PopulationT X_WageWorkerT) (E03Y01C1_GDP E02Y01E2_Migration X_Trade X_ExpenseGDP X_LaborT) (E04Y01C2_InflationRate E02Y01E2_Migration E06Y01C4_SavingsRate X_UnemploymentTILO X_RInterestRate X_Trade X_Import) (E05Y01C3_InvestmentRate E02Y01E2_Migration X_RInterestRate E03Y01C1_GDP X_Export) (E06Y01C4_SavingsRate E02Y01E2_Migration E04Y01C2_InflationRate X_RInterestRate X_RevenueExGrants)


