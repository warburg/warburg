rake d2r:mapping --trace

# sed -E -e 's/d2rq:uriPattern "production\./d2rq:uriPattern "/g' \
#     -e 's/\/resource\/production\./\/resource\//g' \
#     -e 's/d2rq:classDefinitionLabel "production\./d2rq:classDefinitionLabel "/g' \
#     -e 's/d2rq:pattern "production\./d2rq:pattern "/g' \
#     -e 's/#production\./#/g' \
cp doc/vti-mapping.n3 doc/vti-mapping-production.n3
    
sed -e 's/file:\/home\/vti\/apps\/vti\/current\/doc\/vti-mapping.n3/file:\/Users\/tomklaasen\/Workspace\/vti\/doc\/vti-mapping-development.n3/g' \
    -e 's/jdbc:postgresql:vtidata/jdbc:postgresql:vti/g' \
    -e 's/d2rq:username "vtidata";/d2rq:username "tomklaasen";/g' \
    -e 's/http:\/\/rdf.vti.be/http:\/\/localhost:2020/g' \
    -e 's/poobae5s//g' doc/vti-mapping-production.n3 > doc/vti-mapping-development.n3


# -e 's/d2rq:belongsToClassMap <file:\/home\/vti\/apps\/vti\/current\/doc\/vti-mapping.n3#production.\(.*\)>;\n\(\s*\)d2rq:property vocab:\1\_\(.*\)\_id;/d2rq:belongsToClassMap <file:\/home\/vti\/apps\/vti\/current\/doc\/vti-mapping.n3#production.$1>;\n$2d2rq:property vocab:$1_$3;/g' \
#     -e 'N;s/d2rq:belongsToClassMap <file:\/home\/vti\/apps\/vti\/current\/doc\/vti-mapping.n3#(.*)>;\n.*d2rq:property vocab:/LLL\1KKK/g' \
