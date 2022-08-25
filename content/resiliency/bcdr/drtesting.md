# DR Testing Strategies

#### [prev](./drplanning.md) | [home](./readme.md)  | [next](./asr-demo.md)

## Isolated Testing (bubble)
- In this scenario, tests are conducted in an isolated environment. Limits of the tests must be considered, since not all dependencies may be able to be reproduced. Tests are conducted in the isolated environment, so, no data is kept once the tests are concluded.
- Aspects like access to the isolated environment, limits of the tests and others need to also be considered.
- Once tests are concluded, all the temporary data and resources are wiped.
## Full DR Test
- In this scenario, workloads are effectively transitioned to the DR configuration and run for a determined time period. Once tests are completed, the workload(s) are transitioned back, without any data loss.
- Include external dependencies and third-party services in your test plans, considering the mitigation steps required during a site failover. For internet facing workloads test that they are still accessible while running in the DR site.
- Failback steps should begin immediately after the failover is considered successful. Initial replication back to the original (source) environment can take some time.
### Additional learning resources

[Run a disaster recovery drill for Azure VMs](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-dr-drill)