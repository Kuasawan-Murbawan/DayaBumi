USE MerimenTrainDB;
GO

INSERT INTO dbo.USR_PROF (vaPROFNAME) VALUES
('Software Engineer'), ('Medical Doctor'), ('Data Analyst'), ('Civil Engineer'),
('Graphic Designer'), ('Financial Auditor'), ('University Lecturer'),
('Network Administrator'), ('Pharmacist'), ('Digital Marketing Specialist');

INSERT INTO dbo.USR_HOBBY (vaHOBBYNAME, vaLOCATION) VALUES
('Badminton', 'Sports Complex'), ('Swimming', 'Aquatic Center'),
('Freelance Coding', 'Home Office'), ('Photography', 'Outdoor / Studio'),
('Hiking', 'Bukit Gasing Trail'), ('Cycling', 'Putrajaya Lake Track'),
('Reading', 'Public Library'), ('Cooking', 'Home Kitchen'),
('Gaming', 'Home Setup'), ('Rock Climbing', 'Bouldering Gym'),
('Gardening', 'Backyard'), ('Jogging', 'Community Park'),
('Painting', 'Art Studio'), ('Playing Guitar', 'Music Room'),
('Coffee Brewing', 'Local Cafe / Home');

-- Seed 3 initial users (Password for all: Password123 -> SHA-256 hex)
INSERT INTO dbo.USR_DATA
	(vaNAME, vaEMAIL, vaPASSWDHASH, dtDOB, vaABOUTME, iPROFID, vaIC, siAGE, aGENDER,
     bCONTACTMASK, mnEXPECTEDSAL, nEXPYEARS)
VALUES
('Ahmad Danial', 'ahmad.danial@example.com',
 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
 '1995-04-12', 'Full-stack developer focusing on ColdFusion and SQL tuning.', 1,
 '950412145321', 31, 'M', 3, 7500.00, 5.5),
('Nurul Aina', 'nurul.aina@example.com',
 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
 '1998-09-23', 'Data analyst passionate about SQL execution plans.', 3,
 '980923105412', 28, 'F', 5, 6800.00, 3.0),
('Jason Tan', 'jason.tan@example.com',
 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
 '1992-11-05', 'Senior auditor and weekend trail hiker.', 6,
 '921105085119', 34, 'M', 15, 9200.00, 8.0);

INSERT INTO dbo.USR_HOBBYMAP (iUSERID, iHOBBYID) VALUES
(1, 1), (1, 3), (1, 15),
(2, 4), (2, 7),
(3, 5), (3, 6), (3, 12);
GO