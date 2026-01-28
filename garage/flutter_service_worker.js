'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "e434831c99004166f195b450c1695425",
"version.json": "b9f58fbdc3e9ed918f6a477c953f9818",
"index.html": "d9bc4b8db745e262d0921e403b289ee7",
"/": "d9bc4b8db745e262d0921e403b289ee7",
"main.dart.js": "a8c307f4eb12699be4bb69039c0b4af8",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"app-ads.txt": "3790633af9a588ed6df8d8c82db298aa",
"favicon.png": "cce01ebc2c00e2ae346d2208531c3c27",
"icons/Icon-192.png": "fd623698f4678edd818413687418d66a",
"icons/Icon-maskable-192.png": "fd623698f4678edd818413687418d66a",
"icons/Icon-maskable-512.png": "cf2ee8dcb5a5462b3bb1bdc637fae327",
"icons/Icon-512.png": "cf2ee8dcb5a5462b3bb1bdc637fae327",
"manifest.json": "6a11e8390a5a3b728e460f02fcf56525",
".git/config": "5a3b4fe7790cd722d891f07e8fee657b",
".git/objects/3e/502b71c2a02c0acf2749fdf8114a3790529875": "82cf68d82627901f2c0e2db04382b07c",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/9e/42eb480599c077641a3d68acde9a7d42829c1b": "194e1949af1c4b9294b577590c25f07b",
".git/objects/6a/dad7be8b1e9850ddaac986488f908bf4af7023": "d5abe2aa7f2024e6b7a778d243ceb476",
".git/objects/69/b2023ef3b84225f16fdd15ba36b2b5fc3cee43": "6ccef18e05a49674444167a08de6e407",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/0e/e7a9468e27432bc3fd2003386214d2bbfa9a8d": "a3c435a78fe5f873367d6fa4cfdd5412",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/ad/ca9a14928718a637a833c167c44942b944d2cb": "85217a9538efa57e4e2b2b4579f39148",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/bb/a6b8eeedee8e5602216664cf32a209fbf74491": "661593eef85fc26dbc9a055d186d14be",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/c8/db38cabf65cc319e566f1592a576cc16ffd316": "f1d871261da7046199bd6459f66d67fd",
".git/objects/20/4c4f6bb52123a5348eb609531ce3885eedebd6": "930d6c0d467ff99ed9e7fe3ccc68282f",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/1f/0c22227f3ed7ecf90c2ab957251b206fa02a45": "08265b99123aa325af48f003dd18bffc",
".git/objects/28/2c89a2e83c4ddf82b0b6f49495c3961a1aea26": "4235050bb22e904291cc515df3eef735",
".git/objects/75/ad9c03c8c3554ee91e62ac4cd7ebdd80fe24d5": "766c624c946a786f084ca0c462fc00fa",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/5d/e34c97e1b87b638994db058a3ba137308721c0": "8bf3cc1a9674fa18addf761ff18d33c3",
".git/objects/91/ee6c326b1c2c314ca10f84540b1f4701bcd9a8": "0b1b3551d864aa0be8601c367d8fcac1",
".git/objects/65/eda0d27c7be3d6049fe68cae599f8fb22b486e": "a4d4cc4b09dc4ff0f9f270fc6295d903",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/53/61e2bcfb6da07b161d6f7361334f11941a4f3d": "6877800cfccd16793b5b84a1b3012b05",
".git/objects/5e/838f6e529bc4371e8aa51af5e05c60f0df69ed": "a8fd26dca2724f033e009b96084e36de",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/6c/55a2828dedb18b12c470636f9dd4d7322983ac": "bb0ec4fcb9cf8cf29f8c6abcf2ea2044",
".git/objects/39/ce954a2a4793f92ad0f67a0e9a26f575a8fd24": "e11c90b37d5f44dc25a929e2a9cad0c2",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/b6/cdb5387fd9e15192e59e9ab939435e650a0728": "d39c089c445713338a24c7716b2fa5cb",
".git/objects/d5/a6b35f66972239b022d9ceae8c893622ede99d": "9f87d0b2ea9768b64e51f4678dd3c284",
".git/objects/aa/76b55053d13c2e06904b211f6acf675ddb0206": "88dc410f98a38c677e56e5a0ebef3ffc",
".git/objects/aa/0cbf6ee951d227899ba5dfee7080891724c950": "f5a2e388d0dd2a429db515070a4940d9",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/b9/385b4dce229912727a3fe46b3e8fe6d9b27e7b": "f9bd46225450567cc22db107ce36cfd0",
".git/objects/a1/c40e5fb24b323b5737372b9acec0341820c35f": "d8112a5fd2b21d2795d1ac440ae56eab",
".git/objects/c4/7eb04bfeb2d2af6115fb464921d9b54b278f9d": "3701490b5462ea55e02cd811525e016d",
".git/objects/cd/d09a58f0d62d33286e0d1216cc1504b6e01017": "8c4b57c923992cc45903ce4736ea8390",
".git/objects/e6/eb8f689cbc9febb5a913856382d297dae0d383": "466fce65fb82283da16cdd7c93059ff3",
".git/objects/c5/9d2985a99c7f22097aacc86a89d97ce7a2cd8c": "42f296168cecae6db39f0d2ff9712803",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/41/82d34bbdbba01792e76feb217fc000500f980c": "b1bd382712e2e1cb497eef829a7ced84",
".git/objects/84/c67a7a7acf84f063e97af10dbae399c4052163": "3c9c66342a8c97a4bc587002f8d3635f",
".git/objects/4a/899bd61f754dd63e56d2600e2242cc114e04de": "82afbd3d5a3699d282b13cb5bc9a2f1a",
".git/objects/12/3159383299b2083af1212890fe458be4a661c8": "92545ab353b4f08c0e6e04cebd578052",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/1d/53de9663fc1547affde5ab438d6c843079111d": "7bc252edbc40aba35255e8ba6382ea8f",
".git/objects/71/f0b13273a402e37f1d3464665dbf9a30bb0e2f": "8b85adc941256fd16ace1ebe5a3bee62",
".git/objects/82/c5124f5dc895ba7cd9496f51ad6a6e55fd385a": "8289bf5d5ea601b9b99bb6f4ceef4397",
".git/objects/13/887ba7dfc265a8eaac8311448b10b745de017e": "87c583d5b1a44165d2f01b28073e0d49",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "b3e89cf0e0b57727542fe4f1a4a10df2",
".git/logs/refs/heads/main": "b3e89cf0e0b57727542fe4f1a4a10df2",
".git/logs/refs/remotes/origin/gh-pages": "c0d541442edbbaee7dd64426375886b4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "e603a09b9a5710f9a40f4f9f9ced59ac",
".git/refs/remotes/origin/gh-pages": "f3997b3a32e5a6eee835f4359dcb9569",
".git/index": "d82d5e4e05fea696f913d4b99b543876",
".git/COMMIT_EDITMSG": "db51c616140d162a60e7e69cf9a38956",
"assets/NOTICES": "3751d9becbf5c944e1ad1597acef55d0",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "b6d4eacf7a78f1b4c3039980fedbb8ed",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "aee1c16d494d11780bcb617873ff83e1",
"assets/fonts/MaterialIcons-Regular.otf": "2cadd1d424ebf4fffca5bbf48025108b",
"assets/assets/screenshots/screen_4.png": "6f486a4e0b1a6709c0a1e13e5df50240",
"assets/assets/screenshots/screen_5.png": "054523c37f39bffd2d509ef3862b51ee",
"assets/assets/screenshots/screen_2.png": "d8633185c27e3f71a553750e15dcd3d3",
"assets/assets/screenshots/screen_3.png": "490dccc487666894c7a11c8d7d32813e",
"assets/assets/screenshots/screen_1.png": "d29abd5b11be2a1a66f737b9747ed2d7",
"assets/assets/screenshots/app_preview_2.png": "fb5219765a63a5594d3e95fe45c93e7a",
"assets/assets/screenshots/app_preview_1.png": "490dccc487666894c7a11c8d7d32813e",
"privacy.html": "0b8b462e2d376f2ee856564e6ee1362b",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
