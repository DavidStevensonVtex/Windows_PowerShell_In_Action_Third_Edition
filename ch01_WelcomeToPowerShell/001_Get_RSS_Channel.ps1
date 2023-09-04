( [xml] [System.Net.WebClient]::new().DownloadString('https://lifehacker.com/rss')).RSS.Channel.Item | 
    Format-Table title, link