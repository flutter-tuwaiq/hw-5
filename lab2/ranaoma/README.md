# Part 1: Creating an empty list
## Requirements
- Create an empty list that will store data in the form of maps.
- When you add a new entry (map), Each one should contain the following keys: `name`, `age`, `mobile_number`, and `city`.
- Inject the list with at least 3 data entries (3 maps).

## Evaluation Criteria
Your code will be evaluated based on the following:
- The list is created correctly and is empty initially.
- Each map in the list contains the correct keys and values.
- The list is injected with at least 3 data entries.

# Part 2: Creating an endpoint to add data to the list
## Requirements
- Create an HTTP endpoint that accepts POST requests.
- This endpoint should expect a JSON payload containing the data for a new entry in the list.
- The payload should contain the following keys: `name`, `age`, `mobile_number`, and `city`.
- Upon receiving a valid payload, the endpoint should add the data to the list.

## Evaluation Criteria
Your code will be evaluated based on the following:
- The HTTP endpoint is created correctly and can accept POST requests.
- The endpoint can correctly parse and validate JSON payloads.
- The endpoint can add new entries to the list.

# Part 3: Creating an endpoint to display all data in the list
## Requirements
- Create an HTTP endpoint that accepts GET requests.
- Upon receiving a request, the endpoint should return a JSON payload containing all the data in the list.

## Evaluation Criteria
Your code will be evaluated based on the following:
- The HTTP endpoint is created correctly and can accept GET requests.
- The endpoint correctly returns a JSON payload containing all the data in the list.

# Part 4: Creating an endpoint to display one index data in the list
## Requirements
- Create an HTTP endpoint that accepts GET requests with a parameter specifying the index of the data to retrieve.
- Upon receiving a request, the endpoint should return a JSON payload containing the data at the specified index.

## Evaluation Criteria
Your code will be evaluated based on the following:
- The HTTP endpoint is created correctly and can accept GET requests with a parameter.
- The endpoint correctly retrieves and returns the data at the specified index.

# Part 5: Creating an endpoint to delete one index data in the list
## Requirements
- Create an HTTP endpoint that accepts DELETE requests with a parameter specifying the index of the data to delete.
- Upon receiving a request, the endpoint should delete the data at the specified index and return a JSON payload containing the deleted data.

## Evaluation Criteria
Your code will be evaluated based on the following:
- The HTTP endpoint is created correctly and can accept DELETE requests with a parameter.
- The endpoint correctly deletes the data at the specified index and returns a JSON payload containing the deleted data.
