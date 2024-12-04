# ApexUserMonitor


#### contains apex code to enable traceFlag on a longer period than the default 24 hours.
To launch the schedule , run the following command in "anonymous apex" :

`TraceFlagManagerScheduler cronJob = new TraceFlagManagerScheduler('A_USER_ID', 'A_DEBUG_LEVEL_NAME');`
#### // replace the 2 first digit with seconds then minutes then hour to start the schedule
`System.schedule('Tracing user NAME OF THE USER TO TRACE', '0 36 16 ? * *', cronJob);`

###### Cron expression : '0 36 16 ? * *'  means every at 16:36:00
