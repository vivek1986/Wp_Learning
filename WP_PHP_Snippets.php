<?php
// Get near-by cities based on latitude and longitude as direct meta field values.
function get_nearby_cities($lat, $long, $distance){
    global $wpdb;
    $nearbyCities = $wpdb->get_results( 
    "SELECT DISTINCT    
        city_latitude.post_id,
        city_latitude.meta_key,
        city_latitude.meta_value as cityLat,
        city_longitude.meta_value as cityLong,
        ((ACOS(SIN($lat * PI() / 180) * SIN(city_latitude.meta_value * PI() / 180) + COS($lat * PI() / 180) * COS(city_latitude.meta_value * PI() / 180) * COS(($long - city_longitude.meta_value) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance,
        wp_posts.post_title
    FROM 
        wp_postmeta AS city_latitude
        LEFT JOIN wp_postmeta as city_longitude ON city_latitude.post_id = city_longitude.post_id
        INNER JOIN wp_posts ON wp_posts.ID = city_latitude.post_id
    WHERE city_latitude.meta_key = 'city_latitude' AND city_longitude.meta_key = 'city_longitude'
    HAVING distance < $distance
    ORDER BY distance ASC;"
    );

    if($nearbyCities){
        return $nearbyCities;
    }
}
