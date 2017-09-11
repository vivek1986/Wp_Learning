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
