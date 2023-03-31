-- Popualate contacts table
INSERT INTO contacts (contact_id, first_name, last_name, email)
SELECT DISTINCT cf_id, first_name, last_name, email
FROM backers
WHERE cf_id NOT IN (SELECT contact_id FROM contacts);
