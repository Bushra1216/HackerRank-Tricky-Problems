### Spotify interview problem-window function

/* Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. Display the top 5 artist names in ascending order, along with their song appearance ranking.
If two or more artists have the same number of song appearances, they should be assigned the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).*/


with cte1 as(
     select gr.song_id,
            s.name,
            a.artist_id,
            a.artist_name,
            gr.rank 
    from global_song_rank as gr
    join songs as s on gr.song_id=s.song_id
    join artists a on s.artist_id=a.artist_id
    where gr.rank<=10
),

cte2 as(
   select artist_name,
          DENSE_RANK() over(order by count(song_id) desc) as artist_rank 
   from cte1
   group by artist_name
)

select artist_name,artist_rank 
from cte2 
where artist_rank<=5
order by artist_rank;
