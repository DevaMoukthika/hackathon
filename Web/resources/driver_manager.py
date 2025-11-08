"""Small Robot Framework Python library to install browser drivers with webdriver-manager
and ensure driver directory is on PATH so SeleniumLibrary can find the driver.

This library exposes the keyword `Install Driver` (method name `install_driver`).
It avoids using `robot.api.deco.keyword` to improve compatibility with environments
where the Robot Framework API introspection cannot be resolved by the editor/runtime.

Keywords:
  Install Driver    - installs driver for given browser and updates PATH
"""
import os
import logging
import warnings
import urllib3

try:
    from webdriver_manager.chrome import ChromeDriverManager
    from webdriver_manager.firefox import GeckoDriverManager
    from webdriver_manager.microsoft import EdgeChromiumDriverManager
except Exception:
    # Let import errors surface when the library is actually used; keep module import lightweight for editors
    ChromeDriverManager = None
    GeckoDriverManager = None
    EdgeChromiumDriverManager = None


class DriverManager:
    """Robot Framework library class exposing `Install Driver` keyword.

    Usage in Robot file:
      Library    ../resources/driver_manager.py
      Install Driver    chrome
    """

    def __init__(self):
        # Reduce webdriver-manager and urllib3 noise
        logging.getLogger("WDM").setLevel(logging.ERROR)
        logging.getLogger("webdriver_manager").setLevel(logging.ERROR)
        warnings.filterwarnings("ignore", category=DeprecationWarning, module=r"webdriver_manager.*")
        try:
            urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
        except Exception:
            pass

    def install_driver(self, browser="chrome"):
        """Install browser driver and ensure its directory is on PATH.

        Arguments:
            browser: chrome|firefox|edge (default: chrome)

        Returns the full path to the downloaded driver binary.
        """
        browser = (browser or "chrome").lower()

        if browser == "chrome":
            if ChromeDriverManager is None:
                raise RuntimeError("webdriver_manager.chrome is not available; install requirements.txt")
            path = ChromeDriverManager().install()
        elif browser == "firefox":
            if GeckoDriverManager is None:
                raise RuntimeError("webdriver_manager.firefox is not available; install requirements.txt")
            path = GeckoDriverManager().install()
        elif browser in ("edge", "msedge", "microsoftedge"):
            if EdgeChromiumDriverManager is None:
                raise RuntimeError("webdriver_manager.microsoft is not available; install requirements.txt")
            path = EdgeChromiumDriverManager().install()
        else:
            raise ValueError(f"Unsupported browser: {browser}")

        # Ensure driver directory is on PATH so SeleniumLibrary/Open Browser can find it
        driver_dir = os.path.dirname(path)
        path_env = os.environ.get("PATH", "")
        if driver_dir not in path_env:
            os.environ["PATH"] = driver_dir + os.pathsep + path_env

        # Also export an env var for explicit use if needed
        os.environ["WEBDRIVER_PATH"] = path
        return path


# Robot Framework will import module-level callables as keywords too. To avoid
# depending on `robot.api.deco` in environments where it's not resolvable by
# editors/linters, provide a simple module-level wrapper that delegates to the
# class. This exposes `Install Driver` as a keyword (Robot will convert the
# function name to the keyword name).
ROBOT_LIBRARY_SCOPE = 'GLOBAL'


def install_driver(browser="chrome"):
    """Module-level wrapper keyword for compatibility.

    Calls DriverManager.install_driver and returns the installed driver path.
    """
    manager = DriverManager()
    return manager.install_driver(browser)

