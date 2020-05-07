<search class="w-full block">
    <div class="container mx-auto px-4 py-8 border-solid border-b-2">
        <div class="row">
            <h2 class="text-xl mb-4">Search Reviews</h2>
            <form action="/search/reviews">
                <div class="flex flex-row justify-center">
                    <div class="flex flex-grow">
                        <label for="reviewText" class="sr-only">Search text</label>
                        <input type="search" id="reviewText" name="query" class="block p-4 bg-gray-200 text-gray-900 flex-grow" placeholder="search text">
                    </div>
                    <div>
                        <input type="submit" class="bg-blue-700 text-white p-4">
                    </div>
                </div>
            </form>
        </div>
    </div>
</search>