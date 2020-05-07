<cfoutput>
    <main>
        <div class="container mx-auto">
            <div class="flex flex-wrap">
                <div class="<cfif NOT prc.reviews.len()>flex-grow<cfelse>md:w-1/3</cfif>">
                    #renderView( "partials/form" )#
                </div>
    
                <cfif NOT prc.reviews.len()>
                    <p class="bg-orange-300 text-black p-4 mt-8 w-full block">
                        No results found for your search.
                    </p>
                <cfelse>
                    <div class="reviews px-4 md:w-2/3">
                        #renderView(
                            view = "search/review",
                            collection="#prc.reviews#"
                        )#
                    </div>
                </cfif>
            </div>
        </div>
    </main>
</cfoutput>