---
layout: post
title: Pure CSS SVG Loading Animation
date: 2022-06-25 14:25:00
categories: [CSS, SVG, Animation, HTML]
---

First we need some HTML to display the svg. We will use the Loader from this website

```
<div class="cloud-container">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="7.87722 9.61948 33.01 16.88"
      >
        <path
          d="M 12 26 H 37 C 42 26 41 20 37 20 C 38 18 37 15 33 16 C 32 8 15 8 14 17 C 8 16 6 25 12 26"
          class="cloud-back"
        />
        <path
          d="M 12 26 H 37 C 42 26 41 20 37 20 C 38 18 37 15 33 16 C 32 8 15 8 14 17 C 8 16 6 25 12 26"
          class="cloud-front"
        />
    </svg>
</div>
```

Now we need to add some CSS to make the animation work

```
.cloud-container{
  width: 80px;
  margin: auto;
  margin-top: 40px;
}

.cloud-back, .cloud-front{
  stroke-width: 0.5;
  fill: none;
}

.cloud-back{
  stroke: rgb(0, 162, 255);
}

.cloud-front{
  stroke: #eee;
  stroke-dashoffset: 0; /*END 40 */
  stroke-dasharray: 69,12;
  animation: cloudLoader 3s linear infinite;
  animation-fill-mode: forwards;
}

@keyframes cloudLoader{
  0%{
    stroke-dashoffset: 0;
    stroke-dasharray: 69,12;
  }
  50%{
    stroke-dasharray: 40;
  }
  100%{
    stroke-dashoffset: -82;
    stroke-dasharray: 69,12;
  }
}
```

![Preview Picture](/assets/img/SVG_Loading_Animation.png)

## Watch the animation in action

[Codepen](https://codepen.io/skyface753/pen/abqRxMB)
