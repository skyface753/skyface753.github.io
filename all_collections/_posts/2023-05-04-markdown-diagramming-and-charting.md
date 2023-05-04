---
layout: post
title: Mermaid - Markdown diagramming and charting tool
date: 2023-05-03
categories: [Markdown, Mermaid, diagram, chart]
mermaid: true
---

```
sequenceDiagram
    participant Client
    participant Server
    participant Model_Server
    actor Weather_API
    Client->>Server: Request (City)
    Server->>Weather_API: Fetch Weather
    Weather_API->>Server: Response (Weather forecast)
    Server->>Model_Server: Request (City, Weather)
    Model_Server->>Server: Response (Predictions)
    Server->>Client: Response (Predictions)
```

<div class="mermaid">

sequenceDiagram
participant Client
participant Server
participant Model_Server
actor Weather_API
Client->>Server: Request (City)
Server->>Weather_API: Fetch Weather
Weather_API->>Server: Response (Weather forecast)
Server->>Model_Server: Request (City, Weather)
Model_Server->>Server: Response (Predictions)
Server->>Client: Response (Predictions)

</div>

## Mermaid in Jekyll

Create a file named `mermaid.html` in `_include` directory:

```html
<script type="module">
  import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs";
  mermaid.initialize({ startOnLoad: true, theme: "dark" });
</script>
```

- Check the current version of mermaid from [here](https://mermaid.js.org/intro/#cdn)

Update file `_inlude/head.html`

-> this includes the above template file if `page.mermaid` is true.

```markdown
{% raw %}{% if page.mermaid %}
{% include mermaid.html %}
{% endif %}{% endraw %}
```

Now you can use mermaid in your markdown files as follows:

```markdown
---
layout: post
title: Mermaid - Markdown diagramming and charting tool
date: 2023-05-03
categories: [Markdown, Mermaid, diagram, chart]
mermaid: true
---

<div class="mermaid">
sequenceDiagram
participant Client
participant Server
participant Model_Server
actor Weather_API
Client->>Server: Request (City)
Server->>Weather_API: Fetch Weather
Weather_API->>Server: Response (Weather forecast)
Server->>Model_Server: Request (City, Weather)
Model_Server->>Server: Response (Predictions)
Server->>Client: Response (Predictions)
</div>
```
