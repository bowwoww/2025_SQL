insert into dbo.tStudent
    (fStuId,fName,fEmail,fScore)
values
    (115001, 'John', 'Doe@example.com', 85),
    (115002, 'Jane', 'Smith@example.com', 90),
    (115003, 'Emily', 'Johnson@example.com', 95);

-- insert into dbo.tStudent2
-- select * from dbo.tStudent

-- select * into dbo.tStudent2
-- from dbo.tStudent;

UPDATE dbo.tStudent
SET fScore = fScore + 5
WHERE fStuId IN (115001, 115002);