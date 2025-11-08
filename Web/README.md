# Robot Framework Web Test Scaffold

This folder contains a Robot Framework test scaffold configured to:

- Run tests across multiple browsers (Chrome, Firefox, Edge) using webdriver-manager.
- Keep data (credentials, JSON inputs) in a `data/` folder.
- Use a 3-layer structure:
  1. Feature files (Gherkin) -> `tests/features/*.feature`
  2. Mapping layer (Robot keywords that represent Gherkin steps) -> `tests/steps/*.robot`
  3. Low-level implementation (keywords using SeleniumLibrary) -> `keywords/*.robot`
- Produce HTML reports (Robot's built-in `report.html`/`log.html`) and a helper to open them in Chrome.

Folder layout (created):

Web/
  requirements.txt
  README.md
  data/
    credentials.py
    sample_job.json
  resources/
    driver_manager.py
  keywords/
    login_keywords.robot
  tests/
    features/
      login.feature
    steps/
      login_steps.robot
    converted/
      converted_login.robot  # generated from feature (example)
  tools/
    feature_to_robot.py
  reports/
  run_tests.ps1
  view_report.ps1

Quick start (local):

1. Create a virtual environment and activate it.
2. Install dependencies:

   python -m pip install -r requirements.txt

3. Run the simple converter and then run Robot tests (example PowerShell command):

   # from this folder (Web)
   python tools/feature_to_robot.py tests/features/converted_login.feature tests/converted/converted_login.robot
   robot --variable BROWSER:chrome -d reports tests/converted

Notes on browsers:
- Tests accept a `${BROWSER}` variable (one of `chrome`, `firefox`, `edge`). The included `driver_manager` Python keyword will download the appropriate webdriver and ensure it's available on PATH.

Jenkins integration (high-level):

1. On the Jenkins agent, ensure Python is installed.
2. In the pipeline, checkout repository and run:

   python -m pip install -r Web/requirements.txt
   python Web/tools/feature_to_robot.py Web/tests/features/login.feature Web/tests/converted/converted_login.robot
   robot --variable BROWSER:${BROWSER} -d Web/reports Web/tests/converted

3. Archive `Web/reports` as build artifacts and publish HTML reports (plugins: HTML Publisher) or use RobotFramework plugin to parse results.

If you want I can:
- Add a Jenkinsfile with a declarative pipeline example targeting Windows agents.
- Add a CI-friendly script to run tests in parallel (pabot) and to upload results to a test-dashboard.
