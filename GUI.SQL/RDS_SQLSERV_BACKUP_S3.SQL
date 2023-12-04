-- ejecutar respaldo
exec msdb.dbo.rds_backup_database
    @source_db_name='DB_NAME',
    @s3_arn_to_backup_to='arn:aws:s3:::bucket-name/backup/DB_NAME_backup.bak',
    @overwrite_s3_backup_file=1;

-- consultar estado de respaldo
exec msdb.dbo.rds_task_status @db_name='DB_NAME'; -- debe ser SUCCESS


-- crear DB desde respaldo
exec msdb.dbo.rds_restore_database
    @restore_db_name='New_DB_NAME',
    @s3_arn_to_restore_from='arn:aws:s3:::bucket-name/backup/DB_NAME_backup.bak';

-- consultar estado de creacion
exec msdb.dbo.rds_task_status @db_name='New_DB_NAME'; -- debe ser SUCCESS


