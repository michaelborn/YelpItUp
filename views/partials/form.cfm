<cfscript>
    stars = event.getValue( "stars", "" );
    queryText = event.getValue( "query", "" );
</cfscript>
<cfoutput>
    <search class="block">
        <div class="px-4 py-8 border-solid border-b-2">
            <h2 class="text-xl mb-4">Search Reviews</h2>
            <form action="/search/reviews">
                <div class="flex flex-row justify-center mb-4">
                    <div class="flex flex-grow">
                        <label for="reviewText" class="sr-only">Search text</label>
                        <input type="search" id="reviewText" name="query" class="block p-4 bg-gray-200 text-gray-900 flex-grow" placeholder="search text" value="#encodeForHTMLAttribute( queryText )#">
                    </div>
                    <div>
                        <input type="submit" class="bg-blue-700 text-white p-4">
                    </div>
                </div>
                <div class="flex">
                    <label for="stars" class="p-4 flex-grow">search by stars</label>
                    <select name="stars" id="stars" class="block p-4 bg-gray text-gray-900 flex-grow">
                        <option value=""> Any </option>
                        <cfloop from="1" to="5" index="count">
                            <option value="#count#" <cfif stars == count> selected</cfif>>#count#</option>
                        </cfloop>
                    </select>
                </div>
            </form>
        </div>
    </search>
</cfoutput>