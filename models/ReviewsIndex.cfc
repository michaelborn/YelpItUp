component accessors="true"{
    property name="mappings" type="struct";
    property name="settings" type="struct";

    variables.mappings = {
        "_doc" : {
            "properties" : {
                "review_id": { "type" : "keyword" },
                "user_id": { "type" : "keyword" },
                "business_id": { "type" : "keyword" },
                "stars": { "type" : "float" },
                "useful": { "type" : "integer" },
                "funny": { "type" : "integer" },
                "cool": { "type" : "integer" },
                "text": {
                    "type" : "text"
                    // 🤩 Uncomment to use the built-in "english" analyzer
                    // ,"analyzer" : "english"
                    // 🤩 Uncomment to use a custom (configured) english analyzer
                    // ,"analyzer" : "custom_english"
                },
                "date": { "type" : "date" }
            }
        }
    };
    variables.settings = {
        "analysis": {
            "filter": {
                "english_stop": {
                    "type":       "stop",
                    "stopwords":  "_english_" 
                },
                // 🤩 uncomment to prevent stemming of the 'Lowes' brand name keywords
                // @cite https://www.elastic.co/guide/en/elasticsearch/reference/7.6/analysis-keyword-marker-tokenfilter.html
                // "english_keywords": {
                //     "type":       "keyword_marker",
                //     "keywords":   ["lowes","lowe's"] 
                // },
                "english_stemmer": {
                    "type":       "stemmer",
                    "language":   "english"
                },
                "english_possessive_stemmer": {
                    "type":       "stemmer",
                    "language":   "possessive_english"
                },
                // 🤩 uncomment for synonym awesomeness!
                // @cite https://www.elastic.co/guide/en/elasticsearch/reference/7.6/analysis-synonym-tokenfilter.html
                // "english_synonym" : {
                //     "type" : "synonym",
                //     "lenient": true,
                //     "synonyms" : ["lowes, lowe's => lowes"]
                // }
            },
            "analyzer": {
                "custom_english": {
                    "tokenizer":  "standard",
                    "filter": [
                        "lowercase",
                        "english_stop",
                        // 🤩 uncomment for synonym awesomeness!
                        // "english_synonym",
                        // 🤩 uncomment to prevent stemming of the 'Lowes' brand name keywords
                        // "english_keywords",
                        "english_possessive_stemmer",
                        "english_stemmer"
                    ]
                }
            }
        }
    };

    public component function init(){
        return this;
    }
}