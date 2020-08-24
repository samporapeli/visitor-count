# visitor-count
This is a simple setup for counting the page loads of a website. Server is written in Ruby (Sinatra) and frontend is obviously Javascript wrapped in HTML.

# Example
See the recipe page of my famous lentil soup (in Finnish): [samporapeli.fi/linssikeitto/](https://samporapeli.fi/linssikeitto/)
# How to use it?
## Server
You can run your own instance. For testing, in project directory just run ./server.rb. For production, see documentation of Sinatra.
## Frontend
Add this script tag to the head of your html page:
```html
<script src="http://localhost:4567/js/counter.js"></script>
```
And this paragraph tag to where you want the counter to appear:
```html
<p id="visitor-counter"></p>
```
The counter is currently in Finnish, but it's easy to change it in [counter.js](counter.js) (updatePage function).
