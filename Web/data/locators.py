"""
This module contains all web element locators (XPath, ID, CSS selectors, etc.)
used across the test suite. Centralizing locators makes maintenance easier.

Usage in Robot Files:
    Variables    ${CURDIR}/../data/locators.py

Pattern:
    Each page/component should have its own class or section
"""

class LoginPage:
    # Input fields
    USERNAME_FIELD = "xpath://input[@id='username' or @name='username']"
    PASSWORD_FIELD = "xpath://input[@id='password' or @name='password']"
    
    # Buttons
    LOGIN_BUTTON = "xpath://button[@id='login' or @type='submit']"
    
    # Messages and labels
    ERROR_MESSAGE = "xpath://div[contains(@class,'error-message')]"
    SUCCESS_MESSAGE = "xpath://div[contains(@class,'success-message')]"

class Dashboard:
    # Main sections
    WELCOME_MESSAGE = "xpath://h1[contains(text(),'Welcome')]"
    NAVIGATION_MENU = "xpath://nav[@id='main-nav' or @class='main-navigation']"
    
    # Common elements
    LOGOUT_BUTTON = "xpath://button[contains(text(),'Logout') or @id='logout']"
    USER_PROFILE = "xpath://div[contains(@class,'user-profile')]"

class CommonElements:
    # Loading indicators
    LOADING_SPINNER = "xpath://div[contains(@class,'loading-spinner')]"
    
    # Common buttons/links
    BACK_BUTTON = "xpath://button[contains(@class,'back-button')]"
    HOME_LINK = "xpath://a[@href='/home' or contains(@class,'home-link')]"
    
    # Headers and footers
    HEADER_LOGO = "xpath://img[@id='logo' or contains(@class,'logo')]"
    FOOTER_COPYRIGHT = "xpath://div[contains(@class,'copyright')]"