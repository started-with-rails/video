// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// custom theme js
require("custom/jquery.min.js")
require("custom/foundation.min.js")
require("custom/foundation.orbit.js")
require("custom/foundation.interchange.js")
require("custom/fastclick.js")
require("custom/scripts.js")
require("custom/wp-embed.min.js")
require("custom/owl.carousel.min.js")
require("custom/custom.js")

import 'controllers'


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
