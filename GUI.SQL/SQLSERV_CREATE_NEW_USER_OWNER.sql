-- crear usuario
CREATE LOGIN [new_user] WITH PASSWORD = N'****';
USE [DB_NAME];
CREATE USER [new_user] FOR LOGIN [new_user];

-- otorgar permisos
USE [DB_NAME];
ALTER ROLE db_owner ADD MEMBER [new_user];
