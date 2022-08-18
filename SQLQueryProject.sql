Select month,avg(Total_booking) ,host_is_superhost
from (
Select MONTH(A.date) as Month,Count(A.id)over
(partition by month(A.date),year(A.DAte))
As Total_booking ,
C.host_is_superhost as host_is_superhost
from review_toronto_df as A Left join listing_toronto_df B ON
A.listing_id = B.id
Inner join host_toronto_df C ON B.Host_ID = C.HOST_ID
)z group by month,host_is_superhost
 order by month;

 Select *
from (
Select MONTH(A.date) as Month,Count(A.id)over
(partition by month(A.date),year(A.DAte))
As Total_booking ,
C.host_is_superhost as host_is_superhost
from review_toronto_df as A Left join listing_toronto_df B ON
A.listing_id = B.id
Inner join host_toronto_df C ON B.Host_ID = C.HOST_ID
)z 
pivot (Avg(Total_booking)  for host_is_superhost in ([True],[False])) as pvt1 order by Month 



Select host_is_superhost, Avg(host_response_rate) From host_toronto_df Group BY host_is_superhost

Select host_is_superhost, Avg(host_acceptance_rate) From host_toronto_df Group BY host_is_superhost


Select host_is_superhost,host_identity_verified, Count( distinct host_id) 
From host_toronto_df Group BY host_is_superhost,host_identity_verified

Select * From listing_toronto_df


Select A.host_is_superhost,B.instant_Bookable,Count(B.id) From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id Group By A.host_is_superhost,B.instant_bookable


Select A.host_is_superhost,AVG(B.review_Scores_Cleanliness) From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id where B.review_Scores_Cleanliness between 4.5 and 5 Group By A.host_is_superhost 

Select Count(host_id) From host_toronto_df where host_is_superhost = 'False'


Select host_is_superhost, Sum(host_listings_count) From host_toronto_df Group BY host_is_superhost 


Select A.host_is_superhost,Avg(B.price) From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id where A.host_is_superhost is not null
Group By A.host_is_superhost



Select A.host_is_superhost,B.room_type,Count(B.id) From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id Group By A.host_is_superhost,B.room_type



Select host_is_superhost,category, count(id) from 
(Select A.host_is_superhost ,B.id ,Case When B.review_scores_location between 4.5 and 5 then 'Best'
When B.review_scores_location between 4 and 4.4  then 'Good'
When B.review_scores_location between 3 and 3.9  then 'Avg'
When B.review_scores_location <3 then 'bad' end as Category
From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id ) Z Group BY host_is_superhost,category




Select id, Case When review_scores_location between 4.5 and 5 then 'Best'
When review_scores_location between 4 and 4.4  then 'Good'
When review_scores_location between 3 and 3.9  then 'Avg'
When review_scores_location <3 then 'bad' end as Category

From  listing_toronto_df 


Select * From review_toronto_df


---e

Select * From listing_toronto_df
Select Count(id) From df_toronto_availability Group By listing_id


--torr avg price 
Select* From(
Select C.host_is_superhost ,Round(AVG(A.adjusted_price),0) Avg_Price,year(Date) Upcom_Year 
From df_toronto_availability A inner join listing_toronto_df B on A.listing_id = B.id
inner join host_toronto_df C on B.host_id = C.host_id where A.available = 'true' and C.host_is_superhost is not null
Group By C.host_is_superhost,year(Date)) Z
Pivot(Avg(Avg_price) For host_is_superhost in ([True],[False])) As Pvt;

--van avg price
Select* From(
Select C.host_is_superhost ,Round(AVG(A.adjusted_price),0) Avg_Price,year(Date) Upcom_Year 
From df_vancouver_availability A inner join listing_vancouver_df B on A.listing_id = B.id
inner join host_vancouver_df C on B.host_id = C.host_id where A.available = 'true' and C.host_is_superhost is not null
Group By C.host_is_superhost,year(Date)) Z
Pivot(Avg(Avg_price) For host_is_superhost in ([True],[False])) As Pvt;


---torro avilable and not availavle list
Select* From(
Select C.host_is_superhost,A.available ,Count(A.id) total_Available,year(Date) Upcom_Year 
From df_toronto_availability A inner join listing_toronto_df B on A.listing_id = B.id
inner join host_toronto_df C on B.host_id = C.host_id where C.host_is_superhost is not null
Group By C.host_is_superhost,A.available,A.listing_id,(Date)) Z
Pivot(Sum(total_Available) For host_is_superhost in ([True],[False])) As Pvt;


---van avilable and not availavle list
Select* From(
Select C.host_is_superhost,A.available ,Count(A.id) total_Available,year(Date) Upcom_Year 
From df_vancouver_availability A inner join listing_vancouver_df B on A.listing_id = B.id
inner join host_vancouver_df C on B.host_id = C.host_id where C.host_is_superhost is not null
Group By C.host_is_superhost,A.available,A.listing_id,(Date)) Z
Pivot(Sum(total_Available) For host_is_superhost in ([True],[False])) As Pvt;


Select Count(id) Total_Count From df_vancouver_availability 
Select Count(id) Total_Count From df_toronto_availability 


---Q7

Select Count(host_id) No_Of_host From host_toronto_df Group BY host_is_superhost
Select Count(host_id) No_Of_host From host_vancouver_df Group BY host_is_superhost


Select A.host_is_superhost,Count(B.id) total_listing From host_toronto_df A inner join listing_toronto_df B
on A.host_id = B.host_id where A.host_is_superhost is not null
Group By A.host_is_superhost


Select A.host_is_superhost,Count(B.id) total_listing From host_vancouver_df A inner join listing_vancouver_df B
on A.host_id = B.host_id where A.host_is_superhost is not null
Group By A.host_is_superhost



--torr avg price 
Select*From(
Select Round(AVG(A.adjusted_price),0) Avg_Price,year(Date) Upcom_Year 
From df_toronto_availability A inner join listing_toronto_df B on A.listing_id = B.id
inner join host_toronto_df C on B.host_id = C.host_id where A.available = 'true' and C.host_is_superhost is not null
Group By year(Date))z
Pivot (Avg(Avg_Price) For Upcom_Year in ([2022],[2023])) pvt1


Select*From(
Select Round(AVG(A.adjusted_price),0) Avg_Price,year(Date) Upcom_Year 
From df_vancouver_availability A inner join listing_vancouver_df B on A.listing_id = B.id
inner join host_vancouver_df C on B.host_id = C.host_id where A.available = 'true' and C.host_is_superhost is not null
Group By year(Date))z
Pivot (Avg(Avg_Price) For Upcom_Year in ([2022],[2023])) pvt2