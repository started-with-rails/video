/*
This file should contain any js scripts you want to add to the site.
Instead of calling it in the header or throwing it inside wp_head()
this file will be called automatically in the footer so as not to
slow the page load.

*/

// IE8 ployfill for GetComputed Style (for Responsive Script below)
if (!window.getComputedStyle) {
    window.getComputedStyle = function(el, pseudo) {
        this.el = el;
        this.getPropertyValue = function(prop) {
            var re = /(\-([a-z]){1})/g;
            if (prop == 'float') prop = 'styleFloat';
            if (re.test(prop)) {
                prop = prop.replace(re, function () {
                    return arguments[2].toUpperCase();
                });
            }
            return el.currentStyle[prop] ? el.currentStyle[prop] : null;
        }
        return this;
    }
}

// as the page loads, call these scripts
jQuery(document).ready(function($) {
	
		jQuery('.widget h3').each(function () {
   
			var node = jQuery(this).contents().filter(function(){
				return this.nodeType == 3;
			}).first();
			var text = node.text();
			
			var length = text.indexOf(' ');
			if ( length < 0 ) {
				length = text.indexOf(' ')+1;
			}
			
			var first = text.slice(0, length);
			
			node[0].nodeValue = text.slice(first.length);
		
			node.before('<span class="red">' + first + '</span>');
			
   
		});
	
    /*
    Responsive jQuery is a tricky thing.
    There's a bunch of different ways to handle
    it, so be sure to research and find the one
    that works for you best.
    */
    
    /* getting viewport width */
    var responsive_viewport = $(window).width();
    
    /* if is below 481px */
    if (responsive_viewport < 481) {
    
    } /* end smallest screen */
    
    /* if is larger than 481px */
    if (responsive_viewport > 481) {
        
    } /* end larger than 481px */
    
    /* if is above or equal to 768px */
    if (responsive_viewport >= 768) {
    
        /* load gravatars */
        $('.comment img[data-gravatar]').each(function(){
            $(this).attr('src',$(this).attr('data-gravatar'));
        });
        
    }
    
    /* off the bat large screen actions */
    if (responsive_viewport > 1030) {
        
    }
    
	
	// add all your scripts here
    jQuery(document).ready(function(){
        jQuery( ".button" ).on( "mousedown", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'1px'
            });
        });
        jQuery( ".button" ).on( "mouseup", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'0px'
            });
        });

        jQuery( "#searchform .button" ).on( "mousedown", function() {
            jQuery(this).css({
                'position':'absolute',
                'top':'1px'
            });
        });
        jQuery( "#searchform .button" ).on( "mouseup", function() {
            jQuery(this).css({
                'position':'absolute',
                'top':'0px'
            });
        });


        jQuery( ".top-bar .button" ).on( "mousedown", function() {
            jQuery(this).css({
                'position':'absolute',
                'top':'8px'
            });
        });
        jQuery( ".top-bar .button" ).on( "mouseup", function() {
            jQuery(this).css({
                'position':'absolute',
                'top':'7px'
            });
        });

        

         jQuery( ".page-navigation .pagination li a" ).on( "mousedown", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'1px'
            });
        });
        jQuery( ".page-navigation .pagination li a" ).on( "mouseup", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'0px'
            });
        });
        jQuery( ".comment-reply-link" ).on( "mousedown", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'1px'
            });
        });
        jQuery( ".comment-reply-link" ).on( "mouseup", function() {
            jQuery(this).css({
                'position':'relative',
                'top':'0px'
            });
        });
        
    });




    
 
}); /* end of as page load scripts */

var noop = function() {};

  var Orbit = function(el, settings) {
    // Don't reinitialize plugin
    if (el.hasClass(settings.slides_container_class)) {
      return this;
    }

    var self = this,
        container,
        slides_container = el,
        number_container,
        bullets_container,
        timer_container,
        idx = 0,
        animate,
        adjust_height_after = false,
        has_init_active = slides_container.find("." + settings.active_slide_class).length > 0;

    self.cache = {};

    self.slides = function() {
      return slides_container.children(settings.slide_selector);
    };

    if (!has_init_active) {self.slides().first().addClass(settings.active_slide_class)};

    self.update_slide_number = function(index) {
      if (settings.slide_number) {
        number_container.find('span:first').text(parseInt(index)+1);
        number_container.find('span:last').text(self.slides().length);
      }
      if (settings.bullets) {
        bullets_container.children().removeClass(settings.bullets_active_class);
        $(bullets_container.children().get(index)).addClass(settings.bullets_active_class);
      }
    };

    self.update_active_link = function(index) {
      var link = $('[data-orbit-link="'+self.slides().eq(index).attr('data-orbit-slide')+'"]');
      
      if (settings.stack_on_small) {
        container.addClass(settings.stack_on_small_class);
      }

      if (settings.navigation_arrows) {
        container.append($('<a href="#"><span></span></a>').addClass(settings.prev_class));
        container.append($('<a href="#"><span></span></a>').addClass(settings.next_class));
      }

      if (settings.timer) {
        timer_container = $('<div>').addClass(settings.timer_container_class);
        timer_container.append('<span>');
        if (settings.timer_show_progress_bar) {
            timer_container.append($('<div>').addClass(settings.timer_progress_class));
        }
        timer_container.addClass(settings.timer_paused_class);
        container.append(timer_container);
      }

      if (settings.slide_number) {
        number_container = $('<div>').addClass(settings.slide_number_class);
        number_container.append('<span></span> ' + settings.slide_number_text + ' <span></span>');
        container.append(number_container);
      }

      if (settings.bullets) {
        bullets_container = $('<ol>').addClass(settings.bullets_container_class);
        container.append(bullets_container);
        bullets_container.wrap('<div class="orbit-bullets-container"></div>');
        self.slides().each(function(idx, el) {
          var bullet = $('<li>').attr('data-orbit-slide', idx);
          bullets_container.append(bullet);
        });
      }

    };

    self._prepare_direction = function(next_idx, current_direction) {
      var dir = 'next';
      if (next_idx <= idx) { dir = 'prev'; }
      
      if (settings.animation === 'slide') {    
        setTimeout(function(){
          slides_container.removeClass("swipe-prev swipe-next");
          if (dir === 'next') {slides_container.addClass("swipe-next");}
          else if (dir === 'prev') {slides_container.addClass("swipe-prev");}
        },0);
      }
      
      var slides = self.slides();
      if (next_idx >= slides.length) {
        if (!settings.circular) return false;
        next_idx = 0;
      } else if (next_idx < 0) {
        if (!settings.circular) return false;
        next_idx = slides.length - 1;
      }
      var current = $(slides.get(idx))
        , next = $(slides.get(next_idx));
      
      return [dir, current, next, next_idx];
    };

    self._goto = function(next_idx, start_timer) {
      if (next_idx === null) {return false;}
      if (self.cache.animating) {return false;}
      if (next_idx === idx) {return false;}
      if (typeof self.cache.timer === 'object') {self.cache.timer.restart();}
      
      var slides = self.slides();
      self.cache.animating = true;
      var res = self._prepare_direction(next_idx)
        , dir = res[0]
        , current = res[1]
        , next = res[2]
        , next_idx = res[3];

      // This means that circular is disabled and we most likely reached the last slide.
      if (res === false) return false;

      slides_container.trigger('before-slide-change.fndtn.orbit');
      settings.before_slide_change();
      idx = next_idx;

      current.css("transitionDuration", settings.animation_speed+"ms");
      next.css("transitionDuration", settings.animation_speed+"ms");
      
      var callback = function() {
        var unlock = function() {
          if (start_timer === true) {self.cache.timer.restart();}
          self.update_slide_number(idx);
          next.addClass(settings.active_slide_class);
          self.update_active_link(next_idx);
          slides_container.trigger('after-slide-change.fndtn.orbit',[{slide_number: idx, total_slides: slides.length}]);
          settings.after_slide_change(idx, slides.length);
          setTimeout(function(){
            self.cache.animating = false;
          }, 100);
          
        };
        if (slides_container.height() != next.height() && settings.variable_height) {
          slides_container.animate({'height': next.height()}, 250, 'linear', unlock);
        } else {
          unlock();
        }
      };

      if (slides.length === 1) {callback(); return false;}

      var start_animation = function() {
        if (dir === 'next') {animate.next(current, next, callback);}
        if (dir === 'prev') {animate.prev(current, next, callback);}        
      };

      if (next.height() > slides_container.height() && settings.variable_height) {
        slides_container.animate({'height': next.height()}, 250, 'linear', start_animation);
      } else {
        start_animation();
      }
    };
    
    self.next = function(e) {
      e.stopImmediatePropagation();
      e.preventDefault();
      self._prepare_direction(idx + 1);
      setTimeout(function(){
        self._goto(idx + 1);
    }, 100);
    };
    
    self.prev = function(e) {
      e.stopImmediatePropagation();
      e.preventDefault();
      self._prepare_direction(idx - 1);
      setTimeout(function(){
        self._goto(idx - 1)
      }, 100);
    };

    self.link_custom = function(e) {
      e.preventDefault();
      var link = $(this).attr('data-orbit-link');
      if ((typeof link === 'string') && (link = $.trim(link)) != "") {
        var slide = container.find('[data-orbit-slide='+link+']');
        if (slide.index() != -1) {
          setTimeout(function(){
            self._goto(slide.index());
          },100);
        }
      }
    };

    self.link_bullet = function(e) {    
      var index = $(this).attr('data-orbit-slide');
      if ((typeof index === 'string') && (index = $.trim(index)) != "") {
        if(isNaN(parseInt(index)))
        {
          var slide = container.find('[data-orbit-slide='+index+']');
          if (slide.index() != -1) {
            setTimeout(function(){
              self._goto(slide.index() + 1);
            },100);
          }
        }
        else
        {
          setTimeout(function(){
            self._goto(parseInt(index));
          },100);
        }
      }

    }

    self.timer_callback = function() {
      self._goto(idx + 1, true);
    }
    
    self.compute_dimensions = function() {
      var current = $(self.slides().get(idx));
      var h = current.height();
      if (!settings.variable_height) {
        self.slides().each(function(){
          if ($(this).height() > h) { h = $(this).height(); }
        });
      }
      slides_container.height(h);
    };

    self.create_timer = function() {
      var t = new Timer(
        container.find('.'+settings.timer_container_class), 
        settings, 
        self.timer_callback
      );
      return t;
    };

    self.stop_timer = function() {
      if (typeof self.cache.timer === 'object') self.cache.timer.stop();
    };

    self.toggle_timer = function() {
      var t = container.find('.'+settings.timer_container_class);
      if (t.hasClass(settings.timer_paused_class)) {
        if (typeof self.cache.timer === 'undefined') {self.cache.timer = self.create_timer();}
        self.cache.timer.start();     
      }
      else {
        if (typeof self.cache.timer === 'object') {self.cache.timer.stop();}
      }
    };

    self.init = function() {
      self.build_markup();
      if (settings.timer) {
        self.cache.timer = self.create_timer(); 
        Foundation.utils.image_loaded(this.slides().children('img'), self.cache.timer.start);
      }
      
      animate = new CSSAnimation(settings, slides_container);

      if (has_init_active) {
        var $init_target = slides_container.find("." + settings.active_slide_class),
            animation_speed = settings.animation_speed;
        settings.animation_speed = 1;
        $init_target.removeClass('active');
        self._goto($init_target.index());
        settings.animation_speed = animation_speed;
      }

      container.on('click', '.'+settings.next_class, self.next);
      container.on('click', '.'+settings.prev_class, self.prev);

      if (settings.next_on_click) {
        container.on('click', '[data-orbit-slide]', self.link_bullet);
      }
      
      container.on('click', self.toggle_timer);
      if (settings.swipe) {
        slides_container.on('touchstart.fndtn.orbit',function(e) {
          if (self.cache.animating) {return;}
          if (!e.touches) {e = e.originalEvent;}
          e.preventDefault();
          e.stopPropagation();

          self.cache.start_page_x = e.touches[0].pageX;
          self.cache.start_page_y = e.touches[0].pageY;
          self.cache.start_time = (new Date()).getTime();
          self.cache.delta_x = 0;
          self.cache.is_scrolling = null;
          self.cache.direction = null;
          
          self.stop_timer(); // does not appear to prevent callback from occurring          
        })
        .on('touchmove.fndtn.orbit',function(e) {
          if (Math.abs(self.cache.delta_x) > 5) {
            e.preventDefault();
            e.stopPropagation();
          }

          if (self.cache.animating) {return;}          
          requestAnimationFrame(function(){
            if (!e.touches) { e = e.originalEvent; }

            // Ignore pinch/zoom events
            if(e.touches.length > 1 || e.scale && e.scale !== 1) return;

            self.cache.delta_x = e.touches[0].pageX - self.cache.start_page_x;

            if (self.cache.is_scrolling === null) {
              self.cache.is_scrolling = !!( self.cache.is_scrolling || Math.abs(self.cache.delta_x) < Math.abs(e.touches[0].pageY - self.cache.start_page_y) );
            }

            if (self.cache.is_scrolling) {
              return;
            }
            
            var direction = (self.cache.delta_x < 0) ? (idx+1) : (idx-1);
            if (self.cache.direction !== direction) {
              var res = self._prepare_direction(direction);
              self.cache.direction = direction;
              self.cache.dir = res[0];
              self.cache.current = res[1];
              self.cache.next = res[2];
            }

            if (settings.animation === 'slide') {
              var offset, next_offset;
              
              offset = (self.cache.delta_x / container.width()) * 100;
              if (offset >= 0) {next_offset = -(100 - offset);}
              else {next_offset = 100 + offset;}

              self.cache.current.css("transform","translate3d("+offset+"%,0,0)");
              self.cache.next.css("transform","translate3d("+next_offset+"%,0,0)");
            }
          });
        })
        .on('touchend.fndtn.orbit', function(e) {
          if (self.cache.animating) {return;}
          e.preventDefault();
          e.stopPropagation();
          setTimeout(function(){
            self._goto(self.cache.direction);
          }, 50);
        });
      }
      container.on('mouseenter.fndtn.orbit', function(e) {
        if (settings.timer && settings.pause_on_hover) {
          self.stop_timer();
        }
      })
      .on('mouseleave.fndtn.orbit', function(e) {
        if (settings.timer && settings.resume_on_mouseout) {
          self.cache.timer.start();
        }
      });
      
      $(document).on('click', '[data-orbit-link]', self.link_custom);
      $(window).on('load resize', self.compute_dimensions);
      var children = this.slides().find('img');
      Foundation.utils.image_loaded(children, self.compute_dimensions);
      Foundation.utils.image_loaded(children, function() {
        container.prev('.'+settings.preloader_class).css('display', 'none');
        self.update_slide_number(idx);
        self.update_active_link(idx);
        slides_container.trigger('ready.fndtn.orbit');
      });
    };

    self.init();
};
  
jQuery(document).foundation({
	
    orbit: {
        pause_on_hover: true, // Pauses on the current slide while hovering
        resume_on_mouseout: true, // If pause on hover is set to true, this setting resumes playback after mousing out of slide
        circular: true, // Does the slider should go to the first slide after showing the last?
        slide_number: false,
        slide_number_text: 'of',
        timer: true,
        timer_speed: 2000,
        timer_show_progress_bar: false,
        bullets: true,
        swipe: false
    }
});

/*! A fix for the iOS orientationchange zoom bug.
 Script by @scottjehl, rebound by @wilto.
 MIT License.
*/
(function(w){
	// This fix addresses an iOS bug, so return early if the UA claims it's something else.
	if( !( /iPhone|iPad|iPod/.test( navigator.platform ) && navigator.userAgent.indexOf( "AppleWebKit" ) > -1 ) ){ return; }
    var doc = w.document;
    if( !doc.querySelector ){ return; }
    var meta = doc.querySelector( "meta[name=viewport]" ),
        initialContent = meta && meta.getAttribute( "content" ),
        disabledZoom = initialContent + ",maximum-scale=1",
        enabledZoom = initialContent + ",maximum-scale=10",
        enabled = true,
		x, y, z, aig;
    if( !meta ){ return; }
    function restoreZoom(){
        meta.setAttribute( "content", enabledZoom );
        enabled = true; }
    function disableZoom(){
        meta.setAttribute( "content", disabledZoom );
        enabled = false; }
    function checkTilt( e ){
		aig = e.accelerationIncludingGravity;
		x = Math.abs( aig.x );
		y = Math.abs( aig.y );
		z = Math.abs( aig.z );
		// If portrait orientation and in one of the danger zones
        if( !w.orientation && ( x > 7 || ( ( z > 6 && y < 8 || z < 8 && y > 6 ) && x > 5 ) ) ){
			if( enabled ){ disableZoom(); } }
		else if( !enabled ){ restoreZoom(); } }
	w.addEventListener( "orientationchange", restoreZoom, false );
	w.addEventListener( "devicemotion", checkTilt, false );
})( this );

/*
 * Load up Foundation
 */
(function(jQuery) {
  jQuery(document).foundation();
})(jQuery);


/*
 * Scritp start now for video submit page accordian and form validation related funcations
 * 
 */
jQuery( document ).ready(function() {
	var submit_form_button = 0;
	/* Submit form using jquery submit */	
	jQuery("#submit_form_button").click(function(e){
		/*Get the wp_editor content and append in submit form to get the wp_editor data on submit page */
		jQuery('.wp-editor-container textarea').each(function(){
			var name=jQuery(this).attr('id');
			jQuery('<input>').attr({
				type: 'hidden',
				id: name,
				name: name,
				value: tinyMCE.get(name).getContent()
			}).appendTo('#submit_form');
		});
		/* submit form after payment gateway condition is satisfied*/
		jQuery('#submit_form').submit();
		return false;
	});
	finishStep = [];
	currentStep = 'post';
	function addFinishStep(step) {
		if (typeof finishStep === 'undefined') {
			finishStep = [];
		}
		finishStep.push(step);
	}
	function goToByScroll(id){
		  // Reove "link" from the ID
		id = id.replace("link", "");
		  // Scroll
	   jQuery('html,body').animate({
			scrollTop: jQuery("body").offset().top},
			'slow');
	}
	function showNextStep()
	{
		var next = 'post',
		view = this;
		jQuery('.step-wrapper').removeClass('current');
		jQuery('.content').slideUp(500, function() {
			// current step is post
			if (currentStep == 'post') {
				if (parseInt(jQuery('#step-auth').length) === 0)
				{
					console.log('kick');
					user_login = true;
				}
				else
				{
					/* for scroll top for login box in submit form */
					console.log('baby');	
					 jQuery('html, body').animate({
						scrollTop: jQuery("#auth").offset().top
					}, 500);
					
					user_login = false;
				}
				if (user_login) {
					console.log('holiday');	
					goToByScroll('step-auth');
					next = 'payment';
				}
				else
				{
					console.log('rrrrrr');		
					next = 'auth';
				}
			}
			
			// show next step
			jQuery('.step-' + next + '  .content').slideDown(10).end();
			jQuery('.step-' + next).addClass('current');
		});
	}

	jQuery('#continue_submit_from').bind('click',function(event){
		event.preventDefault();
		var $target = jQuery(event.currentTarget),
		$ul = $target.closest('ul'),
		view = this;
		currentStep = 'post';
		jQuery('div#step-post').addClass('complete');		
		if(parseInt(jQuery('#step-auth').length) !== 0 && can_submit_form == 1 )
		{
				
			var recaptcha_val = jQuery('#recaptcha_val').val();
			if(recaptcha_val){
				var captcha = recaptcha_validation();
				if(captcha){
					addFinishStep('step-post');
					showNextStep();
				}
			}else{
					addFinishStep('step-post');
					showNextStep();
			}
		
                        
		  // Call the scroll function	
		}else if(can_submit_form == 1)
		{
				
			jQuery('#submit_form_button').trigger('click');
		}
	});
        
        function recaptcha_validation(){
                var submit_from = jQuery('form#submit_form').serialize();
                var output;
                jQuery.ajax({
                        url:ajaxUrl,
                        type:'POST',
                        async: false,
                        data:submit_from+'&action=submit_form_recaptcha_validation',
                })
                .done(function(results){			
                        if(results==1){
                                jQuery("#common_error").html('');
                                jQuery("#common_error").css('display','none');
                                output= true;
                        }else{
                                jQuery("#common_error").html(results);
                                jQuery("#common_error").css('display','');
                                output= false;
                        }			
                });	
                return output;
        }
	/*jQuery('.submit-video').bind('click',function(event){
		jQuery('#step-post').css('display','block');
		jQuery('#step-auth').css('display','none');
	});*/
	
	// Perform AJAX login on form submit
	jQuery('form#submit_form #submit_form_login').bind('click', function(e){
		jQuery('.wp-editor-container textarea').each(function(){
			var name=jQuery(this).attr('id');
			jQuery('<input>').attr({
				type: 'hidden',
				id: name,
				name: name,
				value: tinyMCE.get(name).getContent()
			}).appendTo('#submit_form');
		});
		var submit_from = jQuery('form#submit_form').serialize();
		var username=jQuery('form#submit_form #user_login').val(); 
		var password= jQuery('form#submit_form #user_pass').val();
		var security= jQuery('form#submit_form #security').val() ;
		var pkg_id = jQuery('form#submit_form #pkg_id').val();
		jQuery.ajax({
			type: 'POST',
			dataType: 'json',
			url: ajaxUrl,
			data:'action=ajaxlogin&username='+username+'&password='+password+'&security='+ security+'&pkg_id='+pkg_id+'&'+submit_from,			
			success: function(data){
				if(data.loggedin)
				{					
					user_login = true;
					currentStep = 'auth';
					jQuery('div#step-auth').addClass('complete');
					submit_form_button = 1;
					jQuery('p.status').css('display','block');
					jQuery('p.status').text(data.message);
					jQuery('#common_error,.common_error_not_login').html('');
					
					jQuery('#loginform').css('display','none');
					jQuery( "#login_user_meta" ).remove();
				}
				else
				{
					jQuery('p.status').css('display','block');
					jQuery('p.status').css('color','red');
					jQuery('p.status').text(data.message);
				}
				if(submit_form_button == 1)
				{
					jQuery('#submit_form_button').trigger('click');
				}
			}
		});
		e.preventDefault();
	});
        
    /*jquery to go to next step while registration on submit form*/
    jQuery('form#submit_form #register_form').bind('click',function(){
        reg_name = jQuery('#user_fname_already_exist').val();
        reg_email = jQuery('#user_email_already_exist').val();
	if(reg_name==1 && reg_email==1){
            user_login = true;
            currentStep = 'auth';
            jQuery('div#step-auth').addClass('complete');
            jQuery('#submit_form').submit();
		
	}
    });
    
    /*jquery to go to next step while registration on submit form*/
    jQuery('.step_enter_detail').bind('click',function(){
        
        jQuery('#post').css("display", "block");
        if(parseInt(jQuery('#step-auth').length) !== 0 ){
            jQuery('#auth').css("display", "none");
        }
    });
    
    
    /* Get the selected category id from input checkbox type*/
    jQuery("#submit_form input[name^='category']").change(function(){
            var a = jQuery("#submit_form input[name='category[]']");
            if(a.length == a.filter(":checked").length){
                    jQuery("#submit_form #selectall").prop('checked', true);
            }else{
                    jQuery("#submit_form #selectall").prop('checked', false);
            }
    });
    
    /**
    * Author post delete code
    */
    jQuery(".autor_delete_link").click(function(){
            if( confirm( delete_confirm) ){
                    jQuery(this).after("<span class='delete_append'><?php _e('Deleting.','templatic');?></span>");
                    jQuery(".delete_append").css({"margin":"5px","vertical-align":"sub","font-size":"14px"});
                    setTimeout(function() {
                       jQuery(".delete_append").html(deleting);
                    }, 700);
                    setTimeout(function() {
                       jQuery(".delete_append").html(deleting);
                    }, 1400);
                    jQuery.ajax({
                            url:ajaxUrl,
                            type:'POST',
                            data:'action=delete_auth_post&security='+delete_auth_post+'&postId='+ jQuery(this).attr('data-deleteid') + '&currUrl='+currUrl,
                            success:function(redirect) {	
                                    window.location.href = redirect;
                            },
                    });

                    return false;
            }else{
                    return false;
            }
    });

});
/* Display select all category function on submit page */
function displaychk(){ 
	dml=document.forms['submit_form'];
	chk = document.getElementsByName('category[]');
	len = chk.length;
	if(document.getElementById("selectall").checked  == true) {
		for (i = 0; i < len; i++)
			chk[i].checked = true ;
		
		jQuery('#category_error').html("");
		jQuery('#category_error').removeClass('message_error2');	
	} else {
		for (i = 0; i < len; i++)
		chk[i].checked = false ;
	}
}


/*User Login/register related script */
jQuery.noConflict();
var checkclick = false;
var reg_email= 0;
var reg_name = 0;
var chkemailRequest=null;
var chknameRequest=null;
function chkemail(e)
{        
    e = 'submit_form';
    if (jQuery("#" + e + " #user_email").val()) {
        var t = jQuery("#" + e + " #user_email").val()
    }
    jQuery("#" + e + " .user_email_spin").remove();
    jQuery("#" + e + " input#user_email").css("display", "inline");
    jQuery("#" + e + " input#user_email").after("<i class='fa fa-circle-o-notch fa-spin user_email_spin ajax-fa-spin'></i>");
    chkemailRequest = jQuery.ajax({
        url: ajaxUrl,
        type: "POST",
        async: true,
        data: "action=tmpl_video_ajax_check_user_email&user_email=" + t,
        beforeSend: function() {
            if (chkemailRequest != null) {
                chkemailRequest.abort()
            }
        },
        success: function(t) {
            var n = t.split(",");
            if (n[1] == "email") {
                if (n[0] > 0) {
                    jQuery("#" + e + " #user_email_error").html(user_email_error);
                    jQuery("#" + e + " #user_email_already_exist").val(0);
                    jQuery("#" + e + " #user_email_error").removeClass("available_tick");
                    jQuery("#" + e + " #user_email_error").addClass("message_error2");
                    reg_email = 0
                } else {
                    jQuery("#" + e + " #user_email_error").html(user_email_verified);
                    jQuery("#" + e + " #user_email_already_exist").val(1);
                    jQuery("#" + e + " #user_email_error").addClass("available_tick");
                    jQuery("#" + e + " #user_email_error").removeClass("message_error2");
                    reg_email = 1
                }
            }
            jQuery("#" + e + " .user_email_spin").remove()
        }
    });
    return true
}
function chkname(e){
    if (jQuery("#" + e + " #user_fname").val()) {
        var t = jQuery("#" + e + " #user_fname").val()
    }
    jQuery("#" + e + " .user_fname_spin").remove();
    jQuery("#" + e + " input#user_fname").css("display", "inline");
    jQuery("#" + e + " input#user_fname").after("<i class='fa fa-circle-o-notch fa-spin user_fname_spin ajax-fa-spin'></i>");
    chknameRequest = jQuery.ajax({
        url: ajaxUrl,
        type: "POST",
        async: true,
        data: "action=tmpl_video_ajax_check_user_email&user_fname=" + t,
        beforeSend: function() {
            if (chknameRequest != null) {
                chknameRequest.abort()
            }
        },
        success: function(t) {
            var n = t.split(",");
            if (n[1] == "fname") {
                if (n[0] > 0) {
                    jQuery("#" + e + " #user_fname_error").html(user_fname_error);
                    jQuery("#" + e + " #user_fname_already_exist").val(0);
                    jQuery("#" + e + " #user_fname_error").addClass("message_error2");
                    jQuery("#" + e + " #user_fname_error").removeClass("available_tick");
                    reg_name = 0
                } else {
                    jQuery("#" + e + " #user_fname_error").html(user_fname_verified);
                    jQuery("#" + e + " #user_fname_already_exist").val(1);
                    jQuery("#" + e + " #user_fname_error").removeClass("message_error2");
                    jQuery("#" + e + " #user_fname_error").addClass("available_tick");
                    if (jQuery("" + e + " #userform div").size() == 2 && checkclick) {
                        document.userform.submit()
                    }
                    reg_name = 1
                }
            }
            jQuery("#" + e + " .user_fname_spin").remove()
        }
    });
    return true
}


function set_login_registration_frm(val)
{
	if(val=='existing_user')
	{
		document.getElementById('login_user_meta').style.display = 'none';
		document.getElementById('login_user_frm_id').style.display = '';
		document.getElementById('login_type').value = val;
	}else  //new_user
	{
		document.getElementById('login_user_meta').style.display = 'block';
		document.getElementById('login_user_frm_id').style.display = 'none';
		document.getElementById('login_type').value = val;
	}
}