# MobileDataUsage
This application display the amount the of data sent over Singapore’s mobile networks.
Fetching the data from url https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=200


# How to use:
1. Clone the repository
2. Install Pod
3. Run application using Xcode

# Application workflow:
1. Application is develope using the MVVM architecture.
2. Used alamofire for api calling
3. Used realm Database for local cache.

![workFlow](https://github.com/Anand-perennial/MobileDataUsage/blob/master/ApplicationFlow.png)

# How to Unit test:
  Added differrent target for UI and functinal Unit testing
  1. Mobile Data Usage Unit Tests
      This target is use to Unit test the viewcontroller, viewModel, DB services and Network services. 
  2. Mobile Data UsageUITests
    This target is use to do UI testing.
    
Code coverge
![Code coverage](https://github.com/Anand-perennial/MobileDataUsage/blob/master/code%20coverage.png)

# Pod files 
1. Alamofire
    Use for network services calling.
2. RealmSwift
   Used realm Database for local cache.
3. NVActivityIndicatorView
   Use to show loading indicator.
4. SwiftLint   
   You can set your coding style rules and force them during development.
   
