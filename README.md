# GenericValidationRules

Implementations of [generic ESS validation
rules](pkg/inst/doc/20180202_maintypes.pdf) in R-validate syntax.  These are
the 20 most commonly used data validation checks as defined by Eurostat.






#### Implemented:

- COV 
- FDL 
- FDM 
- FDT
- REP
- RTS
- RNR
- RWD
- COC
- VIR
- VCO
- VAD
- VSA

### Todo's
- error handling, incorrect parameters, etc.



### Installating the R package

Using `Make` on your OS's command line:

```bash
git clone https://github.com/SNStatComp/GenericValidationRules
cd GenericValidationRules
make install
```

From R, using the `remotes` package:

```r
remotes::install_github("SNStatComp/GenericValidationRules/pkg")
```

