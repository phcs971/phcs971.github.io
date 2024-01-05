'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "a47cebd050b77fc1f393bb962e3832bb",
"index.html": "15455a7b06e07509b5900b8a7e86e895",
"/": "15455a7b06e07509b5900b8a7e86e895",
"main.dart.js": "bd0f9a18deb86f984b978c6772f01a97",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "29e390efb21a36a03edf08ba14d724ae",
"icons/Icon-192.png": "b05e1348291698890334a2265936d679",
"icons/Icon-maskable-192.png": "b05e1348291698890334a2265936d679",
"icons/Icon-maskable-512.png": "54f62251fee3a9917d2c1d7ae49c4485",
"icons/Icon-512.png": "54f62251fee3a9917d2c1d7ae49c4485",
"manifest.json": "5bed6d8b4bce6cbfb30cae7d783884af",
"assets/AssetManifest.json": "da91d796cbc7943f4f8d9ff4d59c3c74",
"assets/NOTICES": "be3c0713f7a5b095c734726ceb3448f4",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "ca7a555c5b7850673deeaeab6714ce77",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "603381057c7b32bf9f8d1a5069c015a3",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/assets/branding/small_logo.svg": "a9eec647d851773220699a5e9acda032",
"assets/assets/branding/icon.png": "ef50a4e30a908a795320b79820b19f75",
"assets/assets/illustrations/contact.svg": "cf987111d0a0ba660bb7b39b6fc0d6ca",
"assets/assets/illustrations/hexagons.svg": "b9d1122b099f1ea4a900c21b44d7cdc3",
"assets/assets/illustrations/developer.svg": "7adc6ea550711c899e01b730b7a8cc13",
"assets/assets/projects/market4u/mk4u_1.jpeg": "ec568d98f676427eaa9cda5638738c75",
"assets/assets/projects/podi/podi_2.jpeg": "3c03510efdcd6d3bfa261bfeabe2100e",
"assets/assets/projects/podi/podi_1.png": "079dbc4def0f418a4325e3c7a8fdb1d0",
"assets/assets/link/appStore.svg": "53ae3a93b0b84e4c66cca2ec97146a47",
"assets/assets/link/github.svg": "326e390c9c9c9461b44230fd561ce6ae",
"assets/assets/link/email.svg": "de76199346a49ff76335e4b4a2d154b5",
"assets/assets/link/playStore.svg": "54eb1f16f0489bf188dd82c391956069",
"assets/assets/link/web.svg": "53daae6d7c20abcc2ab0f177e61b861b",
"assets/assets/link/linkedin.svg": "2e7e4f01fa8d575e5456f782d1194062",
"assets/assets/tech/android.svg": "315d38f45a6a0d98d56e7eed248bc6ed",
"assets/assets/tech/firebase.svg": "2d46be15febe052b655ef455155aeb68",
"assets/assets/tech/github.svg": "326e390c9c9c9461b44230fd561ce6ae",
"assets/assets/tech/agile.svg": "559ff9ee0e09dc410476fc2a6a3ff0d3",
"assets/assets/tech/flutter.svg": "2b8906cc4be78718dc90861e0c2d6ee3",
"assets/assets/tech/dart.svg": "10e17041307cb7b90e1d3b0ea1499f02",
"assets/assets/tech/ios.svg": "e91da4d5c207719f253a47554c1a5143",
"assets/assets/tech/swift.svg": "c1b21fc424af33c09afba7d1847c8de8",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
