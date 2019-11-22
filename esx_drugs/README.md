# esx_drugs
## Requirements
 - [esx_policejob](https://github.com/ESX-Org/esx_policejob)

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-org/esx_drugs
```

### Using Git
```
cd resources
git clone https://github.com/ESX-Org/esx_drugs [esx]/esx_drugs
```

### Manually
- Download https://github.com/ESX-Org/esx_drugs/archive/master.zip
- Put it in the `[esx]` directory

- Import `esx_drugs.sql` in your database
- Add this in your `server.cfg`:

```
start esx_drugs
```
