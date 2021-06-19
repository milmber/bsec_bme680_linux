# bsec_bme680_linux

## Intro

Forked [alexh-name/bsec_bme680_linux](https://github.com/alexh-name/bsec_bme680_linux) to retain compatibility with 
[milmber/homebridge-bme680](https://github.com/milmber/homebridge-bme680) by providing JSON output.

Makes use of [Bosch's provided driver](https://github.com/BoschSensortec/BME680_driver) and can be configured in terms of it.

Readings will be directly output to stdout in a loop.

## Prerequisites

[Download the BSEC software package from Bosch](https://www.bosch-sensortec.com/bst/products/all_products/bsec)
and put it into `./src`, then unpack.

## Configure and Compile

Optionally make changes to make.config.

Depending on how your sensor is embedded it might be surrounded by other
components giving off heat. Use an offset in °C in `bsec_bme680.c` to
compensate. The default is 5 °C:
```
#define temp_offset (5.0f)
```

To compile: `./make.sh`

## Usage

Output will be similar to this:

```
$ ./bsec_bme680
{"timestamp":"2021-06-19 20:33:48","iaq":120.54, "iaq_accuracy":0,"raw_temperature":27.25, "raw_humidity":38.82,"temperature":22.25, "humidity":51.39, "pressure":1010.92, "eCO2":783.109252929687500, "bVOCe":1.1193227767944335937500000,"gas_pressure":1164205, "bsec_status":0 }
{"timestamp":"2021-06-19 20:33:51","iaq":120.54, "iaq_accuracy":0,"raw_temperature":27.42, "raw_humidity":38.76,"temperature":22.31, "humidity":51.43, "pressure":1010.96, "eCO2":783.110046386718750, "bVOCe":1.1193239688873291015625000,"gas_pressure":1176471, "bsec_status":0 }
```
* IAQ (n) - Accuracy of the IAQ score from 0 (low) to 3 (high).
* S: n - Return value of the BSEC library

It can easily be modified in the `output_ready` function.

The BSEC library is supposed to create an internal state of calibration with
increasing accuracy over time. Each 10.000 samples it will save the internal
calibration state to `./bsec_iaq.state` (or wherever you specify the config
directory to be) so it can pick up where it was after interruption.

### bsec_bme680 just quits without a message

Your bsec_iaq.state file might be corrupt or incompatible after an update of the
BSEC library. Try (re)moving it.

