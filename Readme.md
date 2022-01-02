
# Some company test 
[![CI](https://github.com/danielios-hub/ItemsTask/actions/workflows/CI_IOS.yml/badge.svg)](https://github.com/danielios-hub/ItemsTask/actions/workflows/CI_IOS.yml)

## BDD Specs 

### Story: Customer want to see items

### Narrative #1 

```
As an  customer 
I want the app to automatically load a list of items
```

### Scenarios (Acceptance criteria)
```
Given the user has connectivity
When the user requests to see a list of items
then the app should display a list of all items
```

```
Given the user has no connectivity 
When the user requests to see a list of items 
then the app should display an error message
```

### Story: Customer want to see more detail of an item

### Narrative #1 
```
As an customer
I want to see all details about an item
```

### Scenarios (Acceptance criteria)
```
Given the user has connectivity
When the user select an item
The app display all information about the item
```

## Use Cases 

### Load list items

#### Data: 
- URL 

#### Primary course:
1. Execute "Load Items" command with above data 
2. System download data from the URL 
3. System create items from data 
4. System delivers items

#### Invalid data - error course
1. System delivers invalid data error

#### No connectivity - error course
1. System delivers no connectivy error


### Load Item Detail 

#### Data: 
- URL

#### Primary course:
1. User select an item
2. System execute "Load Item {id}"
3. System download data 
4. System create item detail 
5. System deliver item detail 

#### Invalid data - error course
1. System delivers invalid data error

#### No connectivity - error course
1. System delivers no connectivy error


## Requirements
iOS 12.0 and up

## Model Specs

| Property      | Type                |
|---------------|---------------------|
| `id`          | `Int`               |
| `title`       | `String`            |
| `subtitle`    | `String`            |
| `body`        | `String?`           |
| `date`        | `Date` (dd/mm/yyyy HH:mm string)|

### Payload contract

```
GET http://danieldgp.es/items/contentList.json
2xx Response

{
   "items":[
      {
         "id":36,
         "title":"Article 8",
         "subtitle":"Article 8 subtitle with placeholder text",
         "date":"18/04/2013 11:48"
      },
      ...
    ]
}
```

```
GET https://danieldgp.es/items/content/{item-id}.json
2xx Response

{
   "item":{
      "id":36,
      "title":"Article 8",
      "subtitle":"Article 8 subtitle with placeholder text",
      "body":"Article 8 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Article 8",
      "date":"18/04/2013 11:48"
   }
}

```
