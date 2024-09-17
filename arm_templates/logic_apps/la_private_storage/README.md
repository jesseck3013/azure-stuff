# Deploy a Standard Logic App with Private Storage Account

This template is a modified version of
https://github.com/VeeraMS/LogicApp-deployment-with-Secure-Storage, with the
following changes:

- update `FUNCTIONS_EXTENSION_VERSION` from `~3` to `~4`
- set `minimumTlsVersion` to `TLS1_2`
- set `publicNetworkAccess` to `Disabled`
- remove application insight resource
