library(httr)

r <- POST('http://127.0.0.1:5858', body = 'DateString[]' )

print(content(r))

r <- POST('http://127.0.0.1:5858', body = 'RandomVariate[ NormalDistribution[], 3]' )

print(content(r))