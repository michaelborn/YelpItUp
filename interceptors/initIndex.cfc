component {

    /**
     * Initialize the ElasticSearch index on app load/reinit
     */
    void function afterConfigurationLoad( event, interceptData ){
        try {
            setting requesttimeout="500";
            var recreateIndex = true;

            if( recreateIndex ){
                getESClient().deleteIndex( "businesses" );
                getESClient().deleteIndex( "reviews" );
            }
            
            if ( !getESClient().indexExists( "businesses" ) ){
                getIndexBuilder().new(
                    "businesses",
                    {
                        "_doc" = {
                            "properties" : {
                                "business_id": { "type" : "keyword" },
                                "name": { "type" : "text" },
                                "address": { "type" : "text" },
                                "city": { "type" : "keyword" },
                                "state": { "type" : "keyword" },
                                "postal_code": { "type" : "integer" },
                                "latitude": { "type" : "float" },
                                "longitude": { "type" : "float" },
                                "stars": { "type" : "float" },
                                "review_count": { "type" : "integer" },
                                "is_open": { "type" : "boolean" },
                                "attributes": { "type" : "object" },
                                "categories": { "type" : "keyword" },
                                "hours": { "type" : "object" }
                            }
                        }
                    }
                ).save();
            }
            if ( !getESClient().indexExists( "reviews" ) ){
                getIndexBuilder().new(
                    "reviews",
                    {
                        "_doc" = {
                            "properties" : {
                                "review_id": { "type" : "keyword" },
                                "user_id": { "type" : "keyword" },
                                "business_id": { "type" : "keyword" },
                                "stars": { "type" : "float" },
                                "useful": { "type" : "integer" },
                                "funny": { "type" : "integer" },
                                "cool": { "type" : "integer" },
                                "text": { "type" : "text" },
                                "date": { "type" : "date" }
                            }
                        }
                    }
                ).save();
            }

            if ( recreateIndex ){
                populateIndex(
                    file = getSetting( "contentPath" ) & "yelp_academic_dataset_business.json",
                    index = "businesses",
                    idKey = "business_id"
                );


                populateIndex(
                    file = getSetting( "contentPath" ) & "yelp_academic_dataset_review.json",
                    index = "reviews",
                    idKey = "review_id",
                    maxToPopulate = 1000
                );
            }

            // tell ES it's ok to refresh the index shards now.
            // getIndexBuilder().patch( name = "businesses", settings = { "refresh_interval" : "1s" } );
            // getIndexBuilder().patch( name = "reviews", settings = { "refresh_interval" : "1s" } );

        } catch( io.searchbox.client.config.exception.CouldNotConnectException exception ){
            writeOutput( "Unable to connect to ElasticSearch." );
            abort;
        }
    }

    function populateIndex(
        required string file,
        required string index,
        required string idKey,
        numeric maxToPopulate = 100
    ){
        if ( !fileExists( arguments.file ) ){
            throw( "File does not exist", "yelpItUp.interceptors.initIndex", arguments.file );
        }

        var fileObject = fileOpen( arguments.file );
        var populatedCount = 0;
        while( !fileIsEOF( fileObject ) && populatedCount < arguments.maxToPopulate ){

            var json = fileReadLine( fileObject );
            if ( isJSON( json ) ){
                var data = deSerializeJSON( json );

                if ( arguments.index == "businesses" ) {
                    if ( lcase( data.state ) != "ny"){
                        continue;
                    } else {
                        // clean up bad values
                        data["is_open"] = !!data["is_open"];
                    }
                }
                if ( arguments.index == "reviews" ){
                    // clean up bad values
                    data["date"] = dateTimeFormat( lsParseDateTime( data["date"] ), "yyyy-MM-dd'T'HH:nn:ssXXX");
                }
                getDocument()
                    .new(
                        index = arguments.index,
                        properties = data
                    )
                    .setId( data[ arguments.idKey ] )
                    .save();

                populatedCount++;
            }
            
        }
        fileClose( fileObject );
    }

    Client function getESClient() provider="Client@cbElasticsearch"{}

    IndexBuilder function getIndexBuilder() provider="IndexBuilder@cbElasticsearch"{}

    Document function getDocument() provider="Document@cbElasticsearch"{}
}