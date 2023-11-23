# Azure Container Apps Monitoring

### **App Monitoring**

 

- Application insights instrumentation is not available out of the box (single click enablement aka. auto-instrumentation), but can be instrumented at application level using Application Insights SDKs

 

## **Development & Test Phase**

### **Log Streaming**

- View "stdout" & "stderr" logs in real time for any container debugging requirements - Azure portal & CLI

 

### **Container Console**

- Troubleshoot or modify something inside running container - Portal & CLI

 

## **Deployment & Maintenance Phase**

### **Azure Monitor Metrics**

**Namespace** - microsoft.app/containerapps

| **Title**                 | **Description**                                            | **Metric ID**   | **Unit**  |
| ------------------------- | ---------------------------------------------------------- | --------------- | --------- |
| CPU usage  nanocores      | CPU usage in  nanocores (1,000,000,000 nanocores = 1 core) | UsageNanoCores  | nanocores |
| Memory working set  bytes | Working set memory  used in bytes                          | WorkingSetBytes | bytes     |
| Network in bytes          | Network received  bytes                                    | RxBytes         | bytes     |
| Network out bytes         | Network  transmitted bytes                                 | TxBytes         | bytes     |
| Requests                  | Requests processed                                         | Requests        | n/a       |
| Replica count             | Number of active  replicas                                 | Replicas        | n/a       |
| Replica Restart  Count    | Number of replica  restarts                                | RestartCount    | n/a       |

-  Metrics explorer can help in filter and aggregate/split over those metrics - by replica/revision

 

### **Azure Monitor Log Analytics**

- Log analytics to store application logs - stdout/stderr/Dapr sidecar logs.
- One Log Analytics for every ACA Environment
- Log Analytics => Custom logs => ContainerAppConsoleLogs_CL
- Logs both single line of text & serialized json

 

### **Azure Monitor Alerts**

- Metrics alerts: Add multiple conditions & split by dimensions (replica/Revision)
- Log alerts: KQL query. Dimensions available (App name/revision/container/log message)

 

### **Probes**

- Liveness, Readiness & startup delay can be customized
