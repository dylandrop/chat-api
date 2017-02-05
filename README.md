# README

## API usage

The following sections cover signing in, messaging users, and seeing all your messages via cURL.

### Signing in

```bash
curl -H "Content-Type: application/json" -X POST -d '{"user":{"email":"dylandrop@gmail.com","password":"password"}}' https://chat-api-dd.herokuapp.com/sessions | jq .
```

(Using `jq` is optional of course.) This gives something like

```bash
{
  "api_auth_token": "FuS1Qu5ZtXGMLDdWvxQNbhR9"
}
```

The API auth token can be used on subsequent requests for authentication.

### Messaging a user

Using the auth token you got from the previous command, you must construct a JSON blob that contains the email of the user you want to contact, content of your message, and an optional subject.

```bash
curl -H "Content-Type: application/json" -X POST -d '{"message":{"to":"fred@example.com","subject":"Cool stuff","content":"A message"}}' -H "Authorization: Token token=3eMGtFgHZKefHbDGjr6gMavB" http://chat-api-dd.herokuapp.com/messages | jq .
```

The API will return the message you just sent as confirmation:

```bash
{
  "content": "A message",
  "from": "dylandrop@gmail.com",
  "subject": "Cool stuff"
}
```

### Seeing all of your messages

Using the same API token, you can request all of your messages. You can also add an optional filter `with`, which specifies all messages you've shared with a certain user. Lastly, you can also specify a `subject` which filters messages by subject.

```bash
curl -H "Authorization: Token token=3eMGtFgHZKefHbDGjr6gMavB" http://chat-api-dd.herokuapp.com/messages?with=fred@example.com | jq .
```

Example response:

```bash
[
  {
    "content": "A message",
    "from": "dylandrop@gmail.com",
    "subject": "Cool stuff"
  },
  {
    "content": "A message",
    "from": "dylandrop@gmail.com",
    "subject": "Cool stuff"
  },
  {
    "content": "A message",
    "from": "dylandrop@gmail.com",
    "subject": "Cool stuff"
  }
]
```

## Future improvements

API tokens are stored in plaintext. To productionize, they would have to be encrypted in the database.
