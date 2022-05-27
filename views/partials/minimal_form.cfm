<cfoutput>
    <search class="block">
        <form action="/search/reviews">
            <div class="relative">
                <label for="reviewText" class="sr-only">Search</label>
                <input type="search" id="reviewText" name="query" class="block p-4 pr-24 bg-gray-200 text-gray-900 flex-grow" placeholder="search text" value="#encodeForHTMLAttribute( event.getValue( "query", "" ) )#">
                <input type="submit" class="bg-blue-700 text-white p-4 absolute top-0 right-0">
            </div>
        </form>
    </search>
</cfoutput>