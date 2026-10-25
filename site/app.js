(function () {
  "use strict";

  var root = document.documentElement;
  var EXPORT = "assets/export/";
  var reduceMotion = !!(window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches);

  var manifest = null;
  var usage = 38;
  var pullIndex = 0;
  var animTimer = null;
  var animKey = "";

  function $(id) { return document.getElementById(id); }
  function theme() { return root.getAttribute("data-theme") === "light" ? "light" : "dark"; }

  // Stage and tile scenes, from the app's sky bands.
  function bands(colors) {
    var n = colors.length;
    return "linear-gradient(to bottom, " + colors.map(function (c, i) {
      return c + " " + (i * 100 / n) + "% " + ((i + 1) * 100 / n) + "%";
    }).join(", ") + ")";
  }
  var PAL = {
    dark: {
      calm: bands(["#4A323A", "#5E3A40", "#774547", "#8F5249", "#A8604E", "#BE6E53", "#CC7A5A"]),
      warm: bands(["#5A3A33", "#7A4636", "#9A5438", "#B8663B", "#CF7D3E", "#E2933F", "#EAA64A"]),
      hot: bands(["#4A2528", "#69272A", "#8A2E2B", "#A8392F", "#C44736", "#D9573C", "#E4684A"]),
      night: bands(["#241A2B", "#2E2036", "#3B2A44", "#4A3452", "#5C4062", "#6F4E73", "#835C82"]),
      sage: bands(["#2C3A2A", "#3B4D35", "#4E6444", "#628053", "#7B9C65", "#93B578", "#A8C98A"])
    },
    light: {
      calm: bands(["#C3C9E4", "#D0CCE2", "#DECDD8", "#E9CCC9", "#EFC8BA", "#F0C0AB", "#F0B79B"]),
      warm: bands(["#F3D9B6", "#F2CFA3", "#F0C28F", "#EDB47B", "#EBA568", "#E89655", "#E58846"]),
      hot: bands(["#F2C3B8", "#EFB0A2", "#EB9B8B", "#E78673", "#E2705C", "#DC5B45", "#D5472F"]),
      night: bands(["#B9B6D6", "#ADA8CE", "#A19AC5", "#968DBA", "#8C82AE", "#8277A3", "#776C98"]),
      sage: bands(["#D5E6C8", "#C6DDB6", "#B6D3A4", "#A6C892", "#96BD82", "#86B273", "#78A766"])
    }
  };
  var PAL_KEYS = ["calm", "warm", "hot", "night", "sage"];
  var MOOD_SCENE = {
    "mood-idle": "calm", "mood-working": "calm", "mood-sleepy": "night", "mood-strained": "warm",
    "mood-maxed": "hot", "mood-locked": "night", "mood-reset": "sage"
  };

  // Sunrise to night, as the app's usage bar.
  var STOPS = [[0, [244, 199, 142]], [0.45, [224, 136, 95]], [0.8, [212, 87, 63]], [1, [143, 63, 122]]];
  function skyAt(t) {
    for (var i = 1; i < STOPS.length; i++) {
      if (t <= STOPS[i][0]) {
        var a = STOPS[i - 1], b = STOPS[i], k = (t - a[0]) / (b[0] - a[0]);
        var c = a[1].map(function (v, j) { return Math.round(v + (b[1][j] - v) * k); });
        return "rgb(" + c.join(",") + ")";
      }
    }
    return "rgb(143,63,122)";
  }

  // The app's own pixel numerals (PixelNumeral.swift): 3x5 glyphs, 4-cell advance.
  var GLYPHS = {
    "0": [7, 5, 5, 5, 7], "1": [2, 6, 2, 2, 7], "2": [7, 1, 7, 4, 7], "3": [7, 1, 7, 1, 7], "4": [5, 5, 7, 1, 1],
    "5": [7, 4, 7, 1, 7], "6": [7, 4, 7, 5, 7], "7": [7, 1, 1, 1, 1], "8": [7, 5, 7, 5, 7], "9": [7, 5, 7, 1, 7],
    "%": [5, 1, 2, 4, 5]
  };
  function numeral(value, percentColor) {
    var ns = "http://www.w3.org/2000/svg", text = value + "%", cell = 7, w = text.length * 4 - 1;
    var svg = document.createElementNS(ns, "svg");
    svg.setAttribute("width", w * cell);
    svg.setAttribute("height", 5 * cell);
    svg.setAttribute("viewBox", "0 0 " + w + " 5");
    svg.setAttribute("shape-rendering", "crispEdges");
    svg.setAttribute("aria-hidden", "true");
    text.split("").forEach(function (ch, i) {
      GLYPHS[ch].forEach(function (bits, r) {
        for (var c = 0; c < 3; c++) {
          if (!(bits & (4 >> c))) continue;
          var rect = document.createElementNS(ns, "rect");
          rect.setAttribute("x", i * 4 + c);
          rect.setAttribute("y", r);
          rect.setAttribute("width", 1);
          rect.setAttribute("height", 1);
          rect.setAttribute("fill", ch === "%" ? percentColor : "var(--ink)");
          svg.appendChild(rect);
        }
      });
    });
    return svg;
  }

  function moodFor(u) {
    if (u >= 100) return "mood-locked";
    if (u >= 90) return "mood-maxed";
    if (u >= 75) return "mood-strained";
    return "mood-idle";
  }
  function moodInfo(id) {
    if (!manifest) return null;
    for (var i = 0; i < manifest.moods.length; i++) if (manifest.moods[i].id === id) return manifest.moods[i];
    return null;
  }

  // Demo ------------------------------------------------------------------

  function buildCells(el, n) {
    for (var i = 0; i < n; i++) el.appendChild(document.createElement("i"));
  }

  function paintCells() {
    var N = 30, filled = Math.round(usage / 100 * N);
    var cells = $("cells").children;
    for (var i = 0; i < N; i++) {
      var on = i < filled;
      cells[i].style.background = on ? skyAt((i + 0.5) / N) : "";
      cells[i].style.boxShadow = on && i === filled - 1 ? "inset 0 0 0 2px var(--ink)" : "none";
    }
    var weekly = $("weekCells").children;
    for (var j = 0; j < N; j++) weekly[j].style.background = j < 7 ? "var(--weekon)" : "var(--weekoff)";
  }

  function playMood(id) {
    var info = moodInfo(id);
    var frames = info ? info.themes[theme()].frames : null;
    var key = id + "|" + theme();
    if (key === animKey) return;
    animKey = key;
    clearTimeout(animTimer);
    var targets = [$("stageSprite"), $("menuSprite")];
    if (!frames || !frames.length) return;
    var i = 0;
    function show() {
      var src = EXPORT + frames[i].file;
      targets.forEach(function (img) { img.src = src; });
      if (reduceMotion || frames.length < 2) return;
      var wait = Math.max(80, frames[i].duration * 1000);
      i = (i + 1) % frames.length;
      animTimer = setTimeout(show, wait);
    }
    show();
  }

  function renderDemo() {
    var id = moodFor(usage);
    var info = moodInfo(id);
    var th = theme();
    var scene = PAL[th][MOOD_SCENE[id]];
    $("stage").style.background = scene;
    $("moodName").textContent = info ? ({ "mood-idle": "Idle", "mood-strained": "Sweating", "mood-maxed": "Red-hot", "mood-locked": "Ghost" })[id] : "";
    var pct = $("pct");
    var level = usage < 60 ? "var(--sage)" : (usage < 80 ? "var(--amber)" : "var(--ember)");
    pct.textContent = "";
    pct.appendChild(numeral(usage, level));
    pct.setAttribute("aria-label", usage + " percent");
    $("menuLabel").textContent = usage + "% · 3h11m";
    $("stageSprite").alt = "Clawd, looking " + $("moodName").textContent.toLowerCase();
    paintCells();
    playMood(id);
  }

  // Moods strip -----------------------------------------------------------

  function renderMoods() {
    var list = $("moodsList");
    list.textContent = "";
    var th = theme();
    manifest.moods.forEach(function (m) {
      var wrap = document.createElement("div");
      wrap.className = "mood";
      var tile = document.createElement("div");
      tile.className = "tile";
      tile.style.background = PAL[th][MOOD_SCENE[m.id]];
      var img = document.createElement("img");
      img.className = "sprite";
      img.width = 128; img.height = 96; img.loading = "lazy";
      img.alt = "Clawd, " + m.name.toLowerCase();
      img.src = EXPORT + m.themes[th].frames[0].file;
      tile.appendChild(img);
      var text = document.createElement("div");
      var name = document.createElement("span");
      name.className = "n px";
      name.textContent = m.name;
      var hint = document.createElement("span");
      hint.className = "h";
      hint.textContent = m.hint;
      text.appendChild(name); text.appendChild(hint);
      wrap.appendChild(tile); wrap.appendChild(text);
      list.appendChild(wrap);
    });
  }

  // Clawdex ---------------------------------------------------------------

  var pool = [];

  function editionTile(e, idx, big) {
    var th = theme();
    var tile = document.createElement("div");
    tile.className = big ? "tile-big" : "tile";
    tile.style.background = PAL[th][PAL_KEYS[idx % PAL_KEYS.length]];
    var img = document.createElement("img");
    img.className = "sprite";
    img.alt = "Clawd, " + e.name;
    img.width = 160; img.height = 120;
    img.src = EXPORT + "editions/" + th + "/" + e.id + ".png";
    tile.appendChild(img);
    if (big) {
      var tag = document.createElement("div");
      tag.className = "tag-big";
      var n = document.createElement("span"); n.className = "n px"; n.textContent = e.name;
      var c = document.createElement("span"); c.className = "c px"; c.textContent = e.collectionTitle;
      tag.appendChild(n); tag.appendChild(c); tile.appendChild(tag);
    } else {
      var s = document.createElement("span"); s.className = "tag-small px"; s.textContent = e.name; tile.appendChild(s);
    }
    return tile;
  }

  function renderMosaic() {
    var box = $("mosaic");
    box.textContent = "";
    if (!pool.length) return;
    var at = function (i) { return pool[((i % pool.length) + pool.length) % pool.length]; };
    box.appendChild(editionTile(at(pullIndex), pullIndex, true));
    for (var i = 1; i <= 8; i++) box.appendChild(editionTile(at(pullIndex + i), pullIndex + i, false));
  }

  function pull() {
    if (pool.length < 2) return;
    var next = pullIndex;
    while (next === pullIndex) next = Math.floor(Math.random() * pool.length);
    pullIndex = next;
    renderMosaic();
  }

  // Theme -----------------------------------------------------------------

  function renderChrome() {
    var th = theme();
    var btn = $("themeBtn");
    btn.textContent = th === "light" ? "Dark mode" : "Light mode";
    btn.setAttribute("aria-label", th === "light" ? "Switch to dark mode" : "Switch to light mode");
    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta) meta.setAttribute("content", th === "light" ? "#faf4eb" : "#15100d");
    var idle = EXPORT + "moods/" + th + "/mood-idle-0.png";
    $("brandSprite").src = idle;
    $("footSprite").src = idle;
    $("madeSprite").src = EXPORT + "editions/" + th + "/wizard-school.png";
  }

  function setTheme(next) {
    root.setAttribute("data-theme", next);
    try { localStorage.setItem("claudebar-theme", next); } catch (e) {}
    animKey = "";
    renderChrome();
    if (manifest) { renderDemo(); renderMoods(); renderMosaic(); }
  }

  // Boot ------------------------------------------------------------------

  function init() {
    buildCells($("cells"), 30);
    buildCells($("weekCells"), 30);
    $("usage").addEventListener("input", function (e) {
      usage = Number(e.target.value);
      if (manifest) renderDemo();
    });
    $("themeBtn").addEventListener("click", function () { setTheme(theme() === "light" ? "dark" : "light"); });
    $("pullBtn").addEventListener("click", pull);
    $("copyBtn").addEventListener("click", function () {
      var btn = $("copyBtn");
      var text = $("cmdText").textContent;
      var done = function (label) { btn.textContent = label; setTimeout(function () { btn.textContent = "Copy"; }, 1600); };
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(function () { done("Copied"); }, function () { done("Press ⌘C"); selectCommand(); });
      } else { selectCommand(); done("Press ⌘C"); }
    });
    renderChrome();
    paintCells();

    fetch(EXPORT + "manifest.json").then(function (r) { return r.json(); }).then(function (m) {
      manifest = m;
      $("editionCount").textContent = String(m.counts.editions);
      $("collectionCount").textContent = String(m.counts.collections);
      // The showcase draws from original-art editions. The total above counts every edition.
      pool = m.editions.filter(function (e) { return !e.trademarked; });
      pullIndex = pool.length ? Math.floor(Math.random() * pool.length) : 0;
      renderDemo();
      renderMoods();
      renderMosaic();
    }).catch(function () {
      $("moodsList").textContent = "The Clawdex could not load. Reload the page to try again.";
    });
  }

  function selectCommand() {
    var range = document.createRange();
    range.selectNodeContents($("cmdText"));
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
