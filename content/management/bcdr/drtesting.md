# DR Testing Strategies

- Testing (bubble)
    - In this scenario, tests are conducted in an isolated environment. Limits of the tests must be considered, since not all dependencies may be able to be reproduced. Tests are conducted in the isolated environment, so, no data is kept once the tests are concluded.
    - Aspects like access to the isolated environment, limits of the tests and others need to also be considered.
    - Once tests are concluded, all the temporary data and resources are wiped.
- Full DR Test
    - In this scenario, workloads are effectively transitioned to the DR configuration and run for a determined time period. Once tests are completed, the workload(s) are transitioned back, without any data loss.
  - Fail-back
      - To allow for failback, right after the failover is considered successful, replication toward the original (source) environment should be started.
