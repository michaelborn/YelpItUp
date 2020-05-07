<cfoutput>
    <main>
        #renderView( "partials/form" )#

        <div class="reviews">
            #renderView(
                view = "review",
                collection="#prc.reviews#"
            )#
        </div>
    </main>
</cfoutput>