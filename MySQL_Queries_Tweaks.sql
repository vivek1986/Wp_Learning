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

set @latitude = xxx; — center latitude
set @longitude = xxx; — center longitude
set @distance = xx; — search distance

select p.ID, p.post_name, ((ACOS(SIN(@latitude * PI() / 180) * SIN(`latitude.meta_value` * PI() / 180) + COS(@latitude * PI() / 180) * COS(`latitude.meta_value` * PI() / 180) * COS((@longitude – `longitude.meta_value`) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance
from wp_posts p
left join wp_postmeta latitude on latitude.post_id = p.ID and latitude.meta_key = ‘_latitude’
left join wp_postmeta longitude on longitude.post_id = p.ID and longitude.meta_key = ‘_longitude’
having distance < @distance;
