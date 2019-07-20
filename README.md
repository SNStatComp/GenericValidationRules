# GenericValidationRules

Implementations of [generic ESS validation
rules](pkg/inst/doc/20180202_maintypes.pdf) in R-validate syntax.  These are
the 21 main types of validation rules  for validating ESS data as defined by Eurostat.


#### Implemented:

- FDT: FielD Type
- FDL: FielD Length
- FDM: FielD is Manatory or empty
- COV: COdes are Valid
- RWD: Records are Without Duplicate id-keys
- REP: Records Expected are Provided
- RTS: Records are all present for Time Series
- RNR: Records' Number is in a Range
- COC: COdes are Consistent
- VIR: Values are In a Range
- VCO: Values are COnsistent
- VAD: Valueas for Aggregates are consistent with Details
- VSA: Values for Seasonally Adjusted data are plausible


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

