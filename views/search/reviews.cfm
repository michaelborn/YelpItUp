<cfoutput>
    <main>
        #renderView( "partials/form" )#

        <div class="reviews container mx-auto px-4">
            #renderView(
                view = "search/review",
                collection="#prc.reviews#"
            )#
        </div>
    </main>
</cfoutput>