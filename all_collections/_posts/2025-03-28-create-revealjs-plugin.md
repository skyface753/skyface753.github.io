---
layout: post
title: Create your own Reveal.JS plugin
date: 2025-03-28 8:24:00
categories: [Reveal.js, Plugin, JavaScript]
---

In this post, I will introduce you to the process of creating your own Reveal.js plugin. The example plugin I will create is a simple media list that displays a list of media files (images, videos, etc.), at the end of the presentation.

## Folder structure

```bash
my_folder/
|-- media_plugin/
|   |-- media_plugin.js
|   |-- media_plugin.css
|-- package.json
|-- README.md
```

### Files

- `media_plugin/`: This folder contains the main plugin code.
- `media_plugin/media_plugin.js`: This file contains the code for the plugin.
- `media_plugin/media_plugin.css`: This file contains the CSS for the plugin.
- `package.json`: This file contains the package metadata and dependencies.
- `README.md`: This file contains the package description and usage instructions.

## Create the plugin

### Create the `package.json` file

To create the `package.json` file, you can use the following command:

```bash
npm init -y
```

This will create a `package.json` file with the default values. You can then edit the file to add the plugin name, version, description, and other metadata.

> Note: The `package.json` file is not required for a Reveal.js plugin, but it is a good practice to include it for documentation and versioning purposes.

```json
{
  "name": "revealjs-media-list",
  "version": "1.0.2",
  "description": "Add images and videos with captions and sources to your presentation",
  "main": "mediaList/mediaList.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/skyface753/RevealJS-Media-List.git"
  },
  "author": "Sebastian Jörz",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/skyface753/RevealJS-Media-List/issues"
  },
  "homepage": "https://github.com/skyface753/RevealJS-Media-List#readme",
  "files": ["mediaList/mediaList.js", "mediaList/mediaList.css"]
}
```

### Adjust the `files` and `main` fields

The `files` field specifies which files should be included in the package when it is published. The `main` field specifies the main file of the package. In this case, we want to include the `mediaList.js` and `mediaList.css` files in the package.

### Create the `media_plugin.js` file

This file contains the code for the plugin. The plugin will create a list of media files (images, videos, etc.) and display them at the end of the presentation.

> Note: I will only show the key points of the file. For the full code, see the example file at [the end of the post](#example).

```javascript
const RevealImageIllustrations = {
  id: "image-illustrations",
  init: function (deck) {
    // Get configuration options from Reveal config (or set defaults)
    let config = deck.getConfig().imageIllustrations || {};
    config.title = config.title || "List of Illustrations";
    config.fontSizeList = config.fontSizeList || "1rem";
    config.fontSizeCaption = config.fontSizeCaption || "0.8rem";
    config.captionColor = config.captionColor || "#555";

    // Set a CSS variable for the font size (used by the external CSS)
    document.documentElement.style.setProperty(
      "--illustrations-font-size-list",
      config.fontSizeList
    );
    document.documentElement.style.setProperty(
      "--illustrations-font-size-caption",
      config.fontSizeCaption
    );
    document.documentElement.style.setProperty(
      "--illustrations-caption-color",
      config.captionColor
    );

    let imageIllustrations = [];

    function collectImageIllustrations() {
      imageIllustrations = [];
      // Select all images that have either data-source or data-text attributes
      const images = document.querySelectorAll(
        ".slides img[data-source], .slides img[data-text]"
      );
      images.forEach((img, index) => {
        let number = index + 1;
        let source = img.getAttribute("data-source");
        let text = img.getAttribute("data-text");

        // Store illustration info for the final list slide
        imageIllustrations.push({
          number: number,
          src: img.getAttribute("src"),
          source: source,
          text: text,
        });

        // If a data-text attribute is provided, insert a caption below the image
        if (text) {
          // Avoid adding a duplicate caption if one already exists
          if (
            !img.nextElementSibling ||
            !img.nextElementSibling.classList.contains("image-caption")
          ) {
            let caption = document.createElement("div");
            caption.className = "image-caption";
            caption.innerHTML = `<span class="caption-number">Figure ${number}:</span> ${text}`;
            img.insertAdjacentElement("afterend", caption);
          }
        }
      });
    }

    function addIllustrationsSlide() {
      if (imageIllustrations.length === 0) return;

      let listHtml = `<section><h2>${config.title}</h2><ul class="illustrations-list">`;
      imageIllustrations.forEach((item) => {
        let listItem = `<li>Figure ${item.number}: `;
        if (item.text) {
          listItem += `${item.text} `;
        }
        if (item.source) {
          listItem += `(<a href="${item.source}" target="_blank">${item.source}</a>)`;
        } else {
          listItem += `(Own work)`;
        }
        listItem += `</li>`;
        listHtml += listItem;
      });
      listHtml += "</ul></section>";

      document
        .querySelector(".slides")
        .insertAdjacentHTML("beforeend", listHtml);
    }

    deck.on("ready", function () {
      collectImageIllustrations();
      addIllustrationsSlide();
    });
  },
};

// Export the plugin for module systems or attach it to the window object
if (typeof module !== "undefined" && module.exports) {
  module.exports = RevealImageIllustrations;
} else {
  window.RevealImageIllustrations = RevealImageIllustrations;
}
```

#### Explanation of the code

- The plugin is defined as an object with an `id` and an `init` function.
- The `init` function is called when the plugin is initialized. It gets the configuration options from the Reveal.js config and sets default values if not provided.
- The `collectImageIllustrations` function collects all images with `data-source` or `data-text` attributes and stores their information in an array.
- The `addIllustrationsSlide` function creates a new slide at the end of the presentation with a list of all collected images and their sources.
- The `deck.on('ready', ...)` event listener calls the `collectImageIllustrations` and `addIllustrationsSlide` functions when the presentation is ready.
- The plugin is exported for module systems or attached to the `window` object for use in the browser.

### Create the `media_plugin.css` file

This file contains the CSS for the plugin. The CSS styles the list of media files and their captions.

```css
/* Styles for the image captions */
.image-caption {
  font-style: italic;
  text-align: center;
  margin-top: 0px;
  color: var(--illustrations-caption-color, #555);
  font-size: var(--illustrations-font-size-caption, 1rem);
}

.caption-number {
  font-weight: bold;
}

/* Style for the final list slide */
.illustrations-list {
  /* The font size is controlled via the CSS variable set in the JS plugin */
  font-size: var(--illustrations-font-size-list, 1rem);
  list-style-type: none;
  padding-left: 0;
}

.illustrations-list li {
  margin: 0.5em 0;
}
```

### Add the plugin to your Reveal.js presentation

To use the plugin in your Reveal.js presentation, you need to include the JavaScript and CSS files in your HTML file. You can do this by adding the following lines to your HTML file:

```html
<script src="media_plugin/media_plugin.js"></script>
<link rel="stylesheet" href="media_plugin/media_plugin.css" />
```

Then, you need to initialize the plugin in your Reveal.js configuration:

```javascript
Reveal.initialize({
  plugins: [RevealImageIllustrations],
  imageIllustrations: {
    title: "List of Illustrations",
    fontSizeList: "1rem",
    fontSizeCaption: "0.8rem",
    captionColor: "#555",
  },
});
```

This will add the plugin to your Reveal.js presentation and create a list of media files at the end of the presentation.

## Publish the plugin

To publish the plugin, you can use the following command:

```bash
npm publish
```

This will publish the plugin to the npm registry. You can then install the plugin in your Reveal.js presentation using the following command:

```bash
npm install revealjs-media-list
```

This will install the plugin in your project. You can then include the plugin in your HTML file as described above.

> Note: You need to adjust the paths, as the plugin is then installed in the `node_modules` folder.

### Use via JSDelivr

You can also use the plugin via JSDelivr. To do this, you need to include the following lines in your HTML file, **after** publishing the plugin:

```html
<script src="https://cdn.jsdelivr.net/npm/revealjs-media-list@1.0.2/media_plugin/media_plugin.js"></script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/revealjs-media-list@1.0.2/media_plugin/media_plugin.css"
/>
```

This will load the plugin from JSDelivr and make it available for use in your Reveal.js presentation.

## Conclusion

In this post, I have shown you how to create your own Reveal.js plugin that displays a list of media files at the end of the presentation. The plugin collects all images with `data-source` or `data-text` attributes and creates a new slide with a list of all collected images and their sources. You can customize the plugin by changing the configuration options in the Reveal.js initialization. We also discussed how to publish the plugin to npm and use it via JSDelivr.

## Example

[GitHub](https://github.com/skyface753/RevealJS-Media-List)
