'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "97dcd7b46a2af30c58c4244145a32142",
"version.json": "4c2c9c005d2910fb4f6ea2fca84eac6a",
"index.html": "8bb8f8c916a3ee052dd892dac403d7d8",
"/": "8bb8f8c916a3ee052dd892dac403d7d8",
"main.dart.js": "1801ff1c8155b83458bd31a17937036f",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "6151e4a0c0df5a827e5cf533bcc3d7a6",
"assets/AssetManifest.json": "d0cf26bdd8949ed7d9dc392fc49aef6d",
"assets/NOTICES": "2b38c6ab8a6d8da4dd57a758913624fc",
"assets/FontManifest.json": "04886a61b74f8edc6907672e581239a0",
"assets/AssetManifest.bin.json": "a92f7188cc6c3018f0d8f8b7e07b89fa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1877835116f50f20f76dfd3870c523a1",
"assets/fonts/MaterialIcons-Regular.otf": "6ce17c25e2e001fb8381bc33981e5aff",
"assets/assets/images/background/home_background.jpg": "d3e7a8033e1618c280b776b187ed9ab4",
"assets/assets/images/background/cheer_background.png": "4cbbbdea615486e325468f5b6bc48ecc",
"assets/assets/images/background/help_background.png": "4cbbbdea615486e325468f5b6bc48ecc",
"assets/assets/images/background/levels_background.png": "095b938a7f1650fedd2396c433974641",
"assets/assets/images/background/game_background.png": "7ceed038971d6b753351c38d1b5765f7",
"assets/assets/images/borders/border_4.png": "ce884d98d6610fa38638cc6349ef6caf",
"assets/assets/images/borders/border_5.png": "2573f70c4db315192de991a3dee0cf91",
"assets/assets/images/borders/border_7.png": "4be5f409d94489dc0796fec126b47f8b",
"assets/assets/images/borders/border_2.png": "8cd9760e3f5e66651a8c4be53b404f44",
"assets/assets/images/borders/border_3.png": "b0ed4b713b52069fce3fa461b994831e",
"assets/assets/images/borders/border_1.png": "2a8a1a732c965fb8bdb96d5490af66a0",
"assets/assets/images/borders/border_15.png": "d652c10c33cfa04d612ed1ff53c02e05",
"assets/assets/images/borders/border_14.png": "eb30b40bd830f75c951babb15216658d",
"assets/assets/images/borders/border_13.png": "53d19d026224498e2667ab7e6a7dc8cb",
"assets/assets/images/borders/border_12.png": "ad6bad023bc2d5c44971a3d2a299f197",
"assets/assets/images/borders/border_10.png": "109986b29c33284a6cafc16381226e87",
"assets/assets/images/borders/border_11.png": "ad31e94aa8e864c345f27cab9a262838",
"assets/assets/images/borders/border_8.png": "c184b822acb231a0aca18aee47457647",
"assets/assets/images/candle/candle_out.jpg": "4b569b130d74250ca83af89546c6f0d6",
"assets/assets/images/candle/candle_lit.jpg": "e75e69eb7c2b1ffb25de2db2f1df876b",
"assets/assets/images/deco/ice_01.png": "e1117638ce968088f802ae04eb4d002f",
"assets/assets/images/deco/ice_02.png": "ec63b218bd6ca04c8389040544899ccf",
"assets/assets/images/deco/wall.png": "555094e03402d7e81aa423831bf0159f",
"assets/assets/images/tiles/multicolor.png": "ae3ede85c26d69d73a32b156c6a114c6",
"assets/assets/images/tiles/yellow.png": "768748d1d60413d1f70158b1d9d3131a",
"assets/assets/images/tiles/pink.png": "78cbd3d03a7a0ad742e2992e1d121a52",
"assets/assets/images/tiles/blue.png": "038ab28fdc223909a90a2eeba759ef4b",
"assets/assets/images/tiles/orange.png": "ad1df85a5e2c64e860316b78a8bf25ff",
"assets/assets/images/tiles/green.png": "ce337b1b0bfb4428cebc213ba112174f",
"assets/assets/images/tiles/turquoise.png": "b5dfd9f6523d120356d17b7c870450c9",
"assets/assets/images/tiles/cream.png": "c06e4c351014cca8bc6f117b5021ad89",
"assets/assets/images/tiles/choco.png": "a558b1c5b4686014f314bcab6665f022",
"assets/assets/images/tiles/red.png": "a80769bd5c16530c80f7b685dc1142da",
"assets/assets/images/tiles/purple.png": "67ff81ac171c996f06c045f5ab522b93",
"assets/assets/images/items/helper.jpg": "ea2015d4999df89a9f4c9db3d2e2ca3f",
"assets/assets/images/levels/level_current.png": "25e03eaaa3b6aae4b2a64ed5d2a4af34",
"assets/assets/images/levels/level_undone.png": "4a4ebb6bf0672a82ca3674c4a9ca1881",
"assets/assets/images/levels/level_done.png": "7eb930422d95790546f86af2304ef459",
"assets/assets/images/bombs/mine.png": "398316f453308703bb0bd19c7cee1238",
"assets/assets/images/bombs/yellow.png": "babb16fc0e9a1f687d94eeb3a5ff8de7",
"assets/assets/images/bombs/multi_color.png": "597164cb600190a1e14ddae14245402d",
"assets/assets/images/bombs/blue.png": "1ee353e1f2eec8a690f5c3a3dcaee713",
"assets/assets/images/bombs/credits.txt": "5924d2ffd24820b84fa43918936225e9",
"assets/assets/images/bombs/orange.png": "d5e3a9f2cf62617f2c0864872f509ef5",
"assets/assets/images/bombs/tnt.png": "486ee84f8e727c88b6979389dbc88eba",
"assets/assets/images/bombs/green.png": "78ffc169773ba726e0f512b96f54b433",
"assets/assets/images/bombs/rocket.png": "134e884cd970c6e977f0f87404386f81",
"assets/assets/images/bombs/helper.jpg": "a37e02f4da13e8bfd77823571882e907",
"assets/assets/images/bombs/fireball.png": "72c4cdcecb74c23d47bdd753de769f3d",
"assets/assets/images/bombs/red.png": "55f70075ff52d85f5379968db3f8b5db",
"assets/assets/images/bombs/purple.png": "15ba18b94dda8b08ae385e7d39cad972",
"assets/assets/audio/lost.wav": "3c66057ca30502bf8cda7383d070299c",
"assets/assets/audio/win.wav": "7740f4359c53e7415adae7d44307feb0",
"assets/assets/audio/game_start.wav": "b704ae71d6b7147492ce752f40a8f777",
"assets/assets/audio/bomb.wav": "6257b8d00aa498c54260229564862eea",
"assets/assets/audio/Male%2520Voice%2520Example.mp3": "bd334bb5a17735d6143b4b5261dd687d",
"assets/assets/audio/Female%2520Voice%2520Example.mp3": "1edf95a6214c9e18fec9ba1f998f5903",
"assets/assets/audio/move_down.wav": "5415bad0aff80195c2b7e5ae00f20175",
"assets/assets/audio/swap.wav": "3a3734ec432ea13923f68f1dadb34ac3",
"assets/assets/fonts/Iceland-Regular.ttf": "85ac02da5514bcf00db55facd21f26e3",
"assets/assets/levels.json": "d730b3c34432ea3ee5a60b7d6d173db4",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
