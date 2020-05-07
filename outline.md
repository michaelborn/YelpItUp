# Outline

* About Me
* The State of Search
	* Expectations
	* cfSearch
    	* Built into the CF engine and hard to update/upgrade/configure.
    * Database Search
    	* DB's fit a totally different use case.
* Elasticsearch
	* Fast
    * Intelligent
    * Built to scale
* Indexing
	* Tokenization
    * Normalization
* Installing Elasticsearch
* Installing CBElasticsearch
* Configuring CBElasticsearch
	* `config/ColdBox.cfc`
    * Env vars via `.env`
* Creating an Index
* Updating an Index
* Deleting an Index
* Saving a Document
* Updating a Document
* Deleting a Document
* Searching for Documents
	* Requires proper mapping or may not find correct results
* Fuzzy searching
	* LOL, just because it's `match` doesn't mean it's "fuzzy"!
* Search logic
	* `bool`
	* `must`
    * `should`
 * Filter vs Match