## Synopsis

Code sample that demonstrates the ability to utilize JSON and models along with tests. This is an interesting project in that it focuses on specific design patterns around how to handle models vs. views along with very basic design patterns.

A minor MVVC pattern was used to separate model logic, view logic and views from having logic. 

## Original Request

This will consist of three screens:

1. Rider type selection
2. Fare type selection
3. Confirmation

All of the data required for these screens comes from a single JSON response with the following format:


```javascript
{
  "Adult": {
    "fares": [
      { "description": "2.5 Hour Ticket", "price": 2.5 },
      { "description": "1 Day Pass", "price": 5.0 },
      { "description": "30 Day Pass", "price": 100 }
    ],
    "subtext": null
  },
  "Child": {
    "fares": [
      { "description": "2.5 Hour Ticket", "price": 1.5 },
      { "description": "1 Day Pass", "price": 2.0 },
      { "description": "30 Day Pass", "price": 40.0 }
    ],
    "subtext": "Ages 8-17"
  },
  "Senior": {
    "fares": [
      { "description": "2.5 Hour Ticket", "price": 1.0 },
      { "description": "1 Day Pass", "price": 2.0 },
      { "description": "30 Day Pass", "price": 40.0 }
    ],
    "subtext": "Ages 60+"
  }
}
```

The design team has already created wireframes for what each of these screens should look like:
![http://i.imgur.com/NieOGom.png](http://i.imgur.com/NieOGom.png)

## Motivation

I felt this was challenging to do this while working with autolayout, layers and iOS. 

## Tests

Minor Unit Test coverage is provided to cover the models and their logic.
