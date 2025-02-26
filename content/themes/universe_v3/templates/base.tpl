{# This template is the base for all other templates, meaning that all other templates will be adding to the blocks
   in this template, before they're used to create HTML files. #}
<!DOCTYPE html>
<html lang="en" prefix="og: http://ogp.me/ns#">
<head>
    {# If blocks let you check the value of a variable and then generate different HTML depending on that variable.
       The if block below will check if the `google_analytics_id` variable is defined (set in the Python script by
       the "Tracking ID" value of the "Google Analytics" section in the comic_info.ini file). If so, it then
       includes all the text between the `{% if ... %}` and `{% endif %}` blocks. #}
    {%- if google_analytics_id %}
    <!-- Global site tag (gtag.js) - Google Analytics -->
    {# When text is surrounded by {{ these double curly braces }}, it's representing a variable that's passed in by
       the Python script that generates the HTML file. That value is dropped into the existing HTML with no changes.
       For example, if the value passed in to `google_analytics_id` is `UA-123456789-0`, then
       `id={{ google_analytics_id }}` becomes `id=UA-123456789-0` #}
    <script async src="https://www.googletagmanager.com/gtag/js?id={{ google_analytics_id }}"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', '{{ google_analytics_id }}');
    </script>
    {%- endif %}
    {# Naming the blocks like this lets other templates either replace or add onto this block by referencing it by
       name. #}
    {%- block head %}
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" type="text/css" href="{{ content_base_dir }}/themes/{{ theme }}/css/fonts.css">
    <link rel="stylesheet" type="text/css" href="{{ base_dir }}/src/css/advanced_stylesheet.css">
    <link rel="stylesheet" type="text/css" href="{{ content_base_dir }}/themes/{{ theme }}/css/stylesheet.css">
    <link rel="icon" href="{{ base_dir }}/favicon.ico" type="image/x-icon" />
    <meta property="og:title" content="{{ comic_title }}" />
    <meta property="og:description" content="{{ comic_description }}" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="{{ comic_url }}/" />
    <meta property="og:image" content="{{ comic_url + '/content/images/preview_image.png' }}" />
    <meta property="og:image:width" content="100px" />
    <meta property="og:image:height" content="100px" />
    <title>{{ page_title }} - {{ comic_title }}</title>
    {%- endblock %}
</head>
<body>
{% block body %}
<div id="background"></div>
<div id="container">
   <div id="banner">
      <a id="banner-img-link" href="{{ base_dir }}/">
            <img id="banner-img" alt="banner" src="{{ banner_image }}">
      </a>
   </div>
   <div id="links-bar">
   {%- for link in links %}
      <a class="link-bar-link" href="{{ link.url }}">{{ link.name }}</a>
      {% if not loop.last %}<span class="link-bar-separator">|</span>{% endif %}
   {%- endfor %}
   </div>
   <div id="inner-container">
      {% block content %}{% endblock %}

      <div id="powered-by">
         <p><a href="https://twitter.com/i/events/1489393522671239170">twitter</a> - <a href="https://hazelandrobyn.tumblr.com/">tumblr</a> - <a href="https://www.webtoons.com/en/challenge/hazel-and-robyn/list?title_no=637873">webtoons</a> - <a href="https://tapas.io/series/Hazel-and-Robyn/info">tapas</a></p>
         <p>copyleft 2021-2023 Lily B.</br>
         Powered by <a id="powered-by-link" href="https://ryanvilbrandt.github.io/comic_git">comic_git</a> v{{ version }}</p>
      </div>
   </div>
</div>
{% endblock %}
</body>
{# This is the start of the `script` block. Most pages don't need any javascript, so by default it's blank, but some
   pages like infinite_scroll.tpl will fill this in with a <script> tag. #}
{% block script %}{% endblock %}
</html>
