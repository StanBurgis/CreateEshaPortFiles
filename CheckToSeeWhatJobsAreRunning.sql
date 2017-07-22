SELECT
    job.name, 
    job.job_id, 
    job.originating_server, 
    activity.run_requested_date, 
    DATEDIFF( hour, activity.run_requested_date, GETDATE() ) as ElapsedHours,
	((DATEDIFF( hour, activity.run_requested_date, GETDATE() ) * 60) - (DATEDIFF( minute, activity.run_requested_date, GETDATE() ))) as ElapsedMinutes
FROM 
    msdb.dbo.sysjobs_view job
JOIN
    msdb.dbo.sysjobactivity activity
ON 
    job.job_id = activity.job_id
JOIN
    msdb.dbo.syssessions sess
ON
    sess.session_id = activity.session_id
JOIN
(
    SELECT
        MAX( agent_start_date ) AS max_agent_start_date
    FROM
        msdb.dbo.syssessions
) sess_max
ON
    sess.agent_start_date = sess_max.max_agent_start_date
WHERE 
    run_requested_date IS NOT NULL AND stop_execution_date IS NULL