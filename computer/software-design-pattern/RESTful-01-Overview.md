# Concept
Representational state transfer (REST) is a software architectural style that defines a set of constraints to be used for creating Web services. Web services that conform to the REST architectural style, called RESTful Web services, provide interoperability between computer systems on the internet. RESTful Web services allow the requesting systems to access and manipulate textual representations of Web resources by using a uniform and predefined set of stateless operations.


# RESTful Request Method
|Request Method|	Description|
|:---|:---|
|GET | Get a representation of the target resource’s state.|
|POST | Let the target resource process the representation enclosed in the request.|
|PUT |	Set the target resource’s state to the state defined by the representation enclosed in the request.|
|DELETE |	Delete the target resource’s state.|

# Azure RESTful Request Method
|Request Method|	Description|
|:---|:---|
|GET | Get a representation of the target resource’s state.|
|POST | Let the target resource process the representation enclosed in the request.|
|PUT |	Create a resource|
|PATCH |	Update a resource|
|DELETE |	Delete the target resource’s state.|

# HTTP Request Method
+ GET  
The GET method requests a representation of the specified resource. Requests using GET should only retrieve data and should have no other effect. (This is also true of some other HTTP methods.)[1] The W3C has published guidance principles on this distinction, saying, "Web application design should be informed by the above principles, but also by the relevant limitations."[26] See safe methods below.
+ HEAD  
The HEAD method asks for a response identical to that of a GET request, but without the response body. This is useful for retrieving meta-information written in response headers, without having to transport the entire content.
+ POST  
The POST method requests that the server accept the entity enclosed in the request as a new subordinate of the web resource identified by the URI. The data POSTed might be, for example, an annotation for existing resources; a message for a bulletin board, newsgroup, mailing list, or comment thread; a block of data that is the result of submitting a web form to a data-handling process; or an item to add to a database.[27]
+ PUT  
The PUT method requests that the enclosed entity be stored under the supplied URI. If the URI refers to an already existing resource, it is modified; if the URI does not point to an existing resource, then the server can create the resource with that URI.[28]
+ DELETE  
The DELETE method deletes the specified resource.
+ TRACE  
The TRACE method echoes the received request so that a client can see what (if any) changes or additions have been made by intermediate servers.
+ OPTIONS  
The OPTIONS method returns the HTTP methods that the server supports for the specified URL. This can be used to check the functionality of a web server by requesting '*' instead of a specific resource.
+ CONNECT  
[29] The CONNECT method converts the request connection to a transparent TCP/IP tunnel, usually to facilitate SSL-encrypted communication (HTTPS) through an unencrypted HTTP proxy.[30][31] See HTTP CONNECT method.
+ PATCH  
The PATCH method applies partial modifications to a resource.[32]
All general-purpose HTTP servers are required to implement at least the GET and HEAD methods, and all other methods are considered optional by the specification.[33]
