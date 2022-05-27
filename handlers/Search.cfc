component extends="Main" {

    /**
     * API handler /search/reviews
     *
     * @event url arguments and form arguments (form scope) here
     * @rc 
     * @prc 
     */
    function reviews( event, rc, prc ){
        prc.reviews = [];

        if ( event.getValue( "query", "" ) != "" ){
            var results = getInstance( "SearchBuilder@CbElasticSearch" )
                            .new( "reviews" )
                            .match( "text", event.getValue( "query" ) )
                            .highlight( {
                                "fields" : {
                                    "text" : {}
                                }
                            })
                            .execute();

            /**
             * 🚀🚀 Uncomment for fuzzy search awesomeness! 😎😎
             * 
             * @cite https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-fuzzy-query.html
             */
            // var results = getInstance( "SearchBuilder@CbElasticSearch" )
            //             .new( "reviews" )
            //             .setQuery({
            //                 "fuzzy": {
            //                     "text": {
            //                         "value": event.getValue( "query" ),
            //                         "fuzziness" : "AUTO"
            //                     }
            //                 }
            //             })
            //             .highlight( {
            //                 "fields" : {
            //                     "text" : {}
            //                 }
            //             }).execute();
            
            // append each search result hit to the prc.reviews array
            for ( result in results.getHits() ){
                var memento = result.getMemento();
                memento[ "highlights" ] = result.getHighlights();
                prc.reviews.append( memento );
            }
        }
    }
}