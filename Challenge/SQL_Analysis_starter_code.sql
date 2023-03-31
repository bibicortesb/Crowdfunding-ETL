-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id,
	(campaign.backers_count)
FROM campaign
WHERE campaign.outcome = 'live'
ORDER BY campaign.backers_count Desc;




-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id,
	COUNT(backer_id) AS "backers_count"
FROM backers
GROUP BY cf_id
ORDER BY "backers_count" Desc;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT contacts.first_name,
	contacts.last_name,
	contacts.email,
	(campaign.goal-campaign.pledged) AS remaining_amount
INTO email_contacts_remaining_goal_amount
FROM contacts 
INNER JOIN campaign
ON contacts.contact_id = campaign.contact_id
WHERE campaign.outcome = 'live'
ORDER BY remaining_amount DESC;


-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT BK.email,
       BK.first_name, 
       BK.last_name, 
       BK.cf_id, 
       CP.company_name,
       CP.description,
       CP.end_date,
       (CP.goal-CP.pledged) as "Left of Goal",
	   CP.outcome
INTO email_backers_remaining_goal_amount
FROM campaign as CP
LEFT JOIN backers as BK
ON CP.cf_id = BK.cf_id
WHERE CP.outcome = 'live'
GROUP BY BK.email,
       BK.first_name, 
       BK.last_name,
       BK.cf_id, 
       CP.company_name,
       CP.description,
       CP.end_date,
       "Left of Goal",
	   CP.outcome
ORDER BY BK.last_name;


-- Check the table

SELECT * FROM email_backers_remaining_goal_amount

