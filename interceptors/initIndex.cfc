component {

	/**
	 * Initialize the ElasticSearch index on app load/reinit
	 */
	void function afterConfigurationLoad( event, interceptData ){
		try {
			var recreateIndex = true;

			if( recreateIndex ){
				getESClient().deleteIndex( "businesses" );
				getESClient().deleteIndex( "reviews" );
			}
			
			if ( !getESClient().indexExists( "businesses" ) ){
				getIndexBuilder().new(
					"businesses",
					{
						"business_id": { "type" : "keyword" },
						"name": { "type" : "text" },
						"address": { "type" : "text" },
						"city": { "type" : "keyword" },
						"state": { "type" : "keyword" },
						"postal_code": { "type" : "integer" },
						"latitude": { "type" : "decimal" },
						"longitude": { "type" : "decimal" },
						"stars": { "type" : "decimal" },
						"review_count": { "type" : "integer" },
						"is_open": { "type" : "boolean" },
						"attributes": { "type" : "object" },
						"categories": { "type" : "keyword" },
						"hours": { "type" : "object" }
					}
				).save();
			}
			if ( !getESClient().indexExists( "reviews" ) ){
				getIndexBuilder().new(
					"reviews",
					{

					}
				).save();
			}

			if ( recreateIndex ){
				populateIndex(
					files = getSetting( "contentPath" ) & "/yelp_academic_dataset_business.json",
					path = snippetPath,
					index = "businesses",
					idKey = "business_id"
				);
				var reviewFile = ;
				populateIndex(
					file = getSetting( "contentPath" ) & "/yelp_academic_dataset_review.json",
					path = cheatsheetPath,
					index = "reviews",
					idKey = "review_id"
				);
			}
		} catch( io.searchbox.client.config.exception.CouldNotConnectException exception ){
			writeOutput( "Unable to connect to ElasticSearch." );
			abort;
		} catch( cbElasticsearch.JestClient.IndexCreationException exception ){
			writeOutput( "Unable to create index, is ElasticSearch up?" );
			abort;
		}
	}

	function populateIndex(
		required string path,
		required string file,
		required string index,
		required string idKey
	){
		if ( !fileExists( arguments.file ) ){
			throw( "File does not exist", "yelpItUp.interceptors.initIndex", arguments.file );
		}

		var fileObject = fileOpen( arguments.file );
		while( !fileIsEOF( fileObject ) ){

			var json = fileReadLine( fileObject );
			if ( isJSON( json ) ){
				var data = deSerializeJSON( json );
				getDocument()
					.new(
						index = arguments.index,
						properties = data
					)
					.setId( data[ arguments.idKey ] )
					.save();
			}
			
		}
	}

	Client function getESClient() provider="Client@cbElasticsearch"{}

	IndexBuilder function getIndexBuilder() provider="IndexBuilder@cbElasticsearch"{}

	Document function getDocument() provider="Document@cbElasticsearch"{}
}