CREATE TRIGGER Trigger_AuditDB 
ON DATABASE
FOR 
CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
 Declare @op varchar(255),@tbname varchar(255)
 set @op=EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','NVARCHAR(128)')
 set @tbname=EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','NVARCHAR(128)')
 insert into AUDIT_DATABASE(operation,table_name,timestamp)values(@op,@tbname,CURRENT_TIMESTAMP)
END


CREATE TABLE Asset_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    AssetID INT,
    Operation VARCHAR(10),
    OperationTimestamp datetime,
);
 

CREATE TRIGGER asset_insert_trigger
ON Asset
AFTER INSERT 
as
DECLARE @id int
SELECT @id= a.AssetID from inserted a
BEGIN
    INSERT INTO Asset_Log (AssetID, Operation, OperationTimestamp)
    VALUES (@id, 'INSERT', CURRENT_TIMESTAMP);
END;

CREATE TRIGGER asset_update_trigger
ON Asset
AFTER UPDATE
AS
DECLARE @id int
SELECT @id= a.AssetID from inserted a
BEGIN
    INSERT INTO Asset_Log (AssetID, Operation, OperationTimestamp)
    VALUES (@id, 'UPDATE', CURRENT_TIMESTAMP);
END;

CREATE TRIGGER asset_delete_trigger
ON Asset
AFTER DELETE
AS
DECLARE @id int
SELECT @id= a.AssetID from deleted a
BEGIN
    INSERT INTO Asset_Log (AssetID, Operation, OperationTimestamp)
    VALUES (@id, 'DELETE', CURRENT_TIMESTAMP);
END;

select * from Asset_log
select * from AUDIT_DATABASE


