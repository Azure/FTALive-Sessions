# Migration

The process is technically simple, but it requires a lot of planning and testing. The migration process is not reversible, so it is important to plan and test the migration process before you start.
It consists of the following steps:

- Exporting Management Packs from the source management group
- Importing Management Packs to the target management group

## Migration Tool (Accelerator)

- SCOM 2019 and 2022 as a source.
- It is a management pack that you import into your source management group.
- It will help you to identify the management packs that are not compatible with the target management group.

## Agents

- The agents can report to both management groups during the migration process.
- A final cutover is required to switch the agents to the new management group (remove old MG).

## Migrate to Operations Manager managed instance

<https://learn.microsoft.com/en-us/system-center/scom/migrate-to-operations-manager-managed-instance?view=sc-om-2022&tabs=mp-overrides>

[Previous: New Features](newfeatures.md)
