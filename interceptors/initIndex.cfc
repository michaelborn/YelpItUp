component {

    /**
     * Initialize the ElasticSearch index on app load/reinit
     */
    void function afterConfigurationLoad( event, interceptData ){
        try {
            setting requesttimeout="500";
            var recreateIndex = true;

            if( recreateIndex ){
                getESClient().deleteIndex( "reviews" );
            }

            if ( !getESClient().indexExists( "reviews" ) ){
                var index = new models.ReviewsIndex();
                getIndexBuilder().new(
                    "reviews",
                    {
                        "mappings" : index.getMappings(),
                        "settings" : index.getSettings()
                    }
                ).save();
            }

            if ( recreateIndex ){
                populateIndex(
                    file = getSetting( "contentPath" ) & "yelp_academic_dataset_review.json",
                    index = "reviews",
                    idKey = "review_id",
                    maxToPopulate = 1000
                );
            }

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