# API Endpoints
Subject to change...

<!-- Format for API Endpoints -->
<!-- 
    ##<Request>
        <Description>
    ### Parameters
        @parameter = <parameter_name> (<parameter type>) <description>
    ###<Expected Response Type> (<Content Type>)
        <Expected Response>
    .
    . (More expected responses)
    .
 -->

## GET /api/recipes/\<id\>/
Retrieves information about the given recipe

### Response 200 (application/json) <a name="recipefmt"></a>
```json
{
    "id": ,
    "name": ,
    "description": ,
    "ingredients": [
        {
            "name": "INGREDIENT_NAME",
            "amount": "INGREDIENT_AMOUNT",
            "unit": "INGREDIENT_UNITS",
        },
    ],
    "instructions": ,
    "created_at": ,
    "updated_at": ,
    "rating": ,
    "author": ,
}
```

## POST /api/recipes/
Creates a recipe with the given paramters. The API infers if the recipe should be created internally or as a link to an external recipe.

### Internal Recipe Format
```json
{
    "name": ,
    "description": ,
    "ingredients": [
        {
            "name": "INGREDIENT_NAME",
            "amount": "INGREDIENT_AMOUNT",
            "unit": "INGREDIENT_UNITS",
        },
    ],
    "instructions": ,
}
```
### External Recipe Format
```json
{
    "name": ,
    "url": ,
}
```

## PUT /api/recipes/\<id\>/
Updates the recipe with the new fields.

### Body format
```json
{
    "FIELD_NAME": "NEW_VALUE",
    "FIELD_NAME2": "NEW_VALUE2",
}
```

### Response 200 
Updated information about the recipe. See [Recipe Format](#recipefmt)

## DELETE /api/recipes/\<id\>/
Deletes the given recipe

### Response 200
