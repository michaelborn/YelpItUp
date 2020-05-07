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
                            .execute();
            
            // append each search result hit to the prc.reviews array
            for ( result in results.getHits() ){
                prc.reviews.append( result.getMemento() );
            }
        }
    }
}