-- Get the nearest locations list from Wordpress database when lat-lng are stored as meta_fields
SELECT a.post_id, a.meta_value as lat, b.meta_value as lng, c.meta_value as  address
FROM lbt_postmeta as a, 
lbt_postmeta as b,
lbt_postmeta as c
WHERE a.meta_key = "geo_latitude"
AND b.meta_key= "geo_longitude"
AND c.meta_key= "geo_address"
AND a.post_id = b.post_id
AND a.post_id = c.post_id

-- OR
set @latitude = xxx; — center latitude
set @longitude = xxx; — center longitude
set @distance = xx; — search distance

select p.ID, p.post_name, ((ACOS(SIN(@latitude * PI() / 180) * SIN(`latitude.meta_value` * PI() / 180) + COS(@latitude * PI() / 180) * COS(`latitude.meta_value` * PI() / 180) * COS((@longitude – `longitude.meta_value`) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance
from wp_posts p
left join wp_postmeta latitude on latitude.post_id = p.ID and latitude.meta_key = ‘_latitude’
left join wp_postmeta longitude on longitude.post_id = p.ID and longitude.meta_key = ‘_longitude’
having distance < @distance;

-- Unserialize through MySQL without PHP
-- Example serialized string :- a:5:{s:9:"invoiceid";s:1:"8";s:8:"balance";i:5;s:14:"broughtforward";i:3;s:6:"userid";s:5:"13908";s:10:"customerid";s:1:"3";}
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',1),':',-1) AS fieldname1,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',2),':',-1) AS fieldvalue1,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',3),':',-1) AS fieldname2,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',4),':',-1) AS fieldvalue2,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',5),':',-1) AS fieldname3,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',6),':',-1) AS fieldvalue3,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',7),':',-1) AS fieldname4,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',8),':',-1) AS fieldvalue4,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',9),':',-1) AS fieldname5,
SUBSTRING_INDEX(SUBSTRING_INDEX(old_data,';',10),':',-1) AS fieldvalue5
FROM table;

-- Example serialized string 2 :- a:3:{s:7:"address";s:29:"Melbourne VIC 3004, Australia";s:3:"lat";s:18:"-37.80754617047211";s:3:"lng";s:18:"144.95670318603516";}
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(meta_value,';',4),':',-1) AS latitude
  FROM wp481_postmeta
  WHERE meta_key = 'location'
    AND post_id = 6;
