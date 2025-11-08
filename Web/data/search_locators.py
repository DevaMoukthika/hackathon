class SearchPage:
    # Google search elements
    SEARCH_INPUT = "xpath://input[@name='q']"
    SEARCH_BUTTON = "xpath://input[@name='btnK' or @type='submit']"
    ACCEPT_COOKIES = "xpath://button[contains(., 'Accept all')]"
    
    # Search results
    SEARCH_RESULTS = "xpath://div[@id='search']//h3"
    ALL_RESULTS = "xpath://div[@id='search']"
    
    # Suggestions
    SEARCH_SUGGESTIONS = "xpath://ul[@role='listbox']//li//div[@class='wM6W7d']"