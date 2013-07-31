-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 30, 2013 at 09:57 PM
-- Server version: 5.6.12-log
-- PHP Version: 5.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pmgr_demo`
--
CREATE DATABASE IF NOT EXISTS `pmgr_demo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `pmgr_demo`;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(100) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=68 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_name`) VALUES
(67, 'new project number two'),
(66, 'new project again'),
(65, 'new project');

-- --------------------------------------------------------

--
-- Table structure for table `project_bugs`
--

CREATE TABLE IF NOT EXISTS `project_bugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `entry` text NOT NULL,
  `open` tinyint(1) NOT NULL,
  `date_opened` text NOT NULL,
  `date_closed` text NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `project_bugs`
--

INSERT INTO `project_bugs` (`id`, `project_id`, `entry`, `open`, `date_opened`, `date_closed`, `notes`) VALUES
(1, 1, 'The save button in the form, when set to ''type=submit'', is causing the entire page to refresh/reload. Changed it to type=button for now to get new entries inserted into the log without them disappearing as a result of the form''s page refresh.', 0, '4-27-12', '', 'I think the php file was creating a new page with only its return result, which was either an echoed 0 for success or "error connecting to database" for failure.  This one was fixed a while back so I don''t quite remember.'),
(2, 1, 'Data for bugs and specs not displaying immediately after a save.  The insert function require a json object or maybe just any kind of object will work as long as it matched the structure of the json object.', 0, '5-20-13', '5-20-13', 'Creating an object after save and passing it to the same function that loads bugs and specs when the data is initially loaded.'),
(3, 1, 'Saved a spec entry and it got inserted immediately onto the log tab. The data did save to the correct table and will display in the proper tab on reload.', 0, '5-20-13', '5-23-13', 'Needed to identify which tab was active.'),
(4, 2, 'The borders around the search field and the search icon are in different places depending on the browser. Temporarily moved the search icon to the side of the search box.', 1, '5-20-13', '5-20-13', ''),
(5, 1, 'Data not saving to the database when a single quote is in the text. Need to escape the characters.  When phpMyAdmin shows an insert the single quote seems to be escaped by another single quote.', 0, '5-22-13', '5-22-13', 'Fixed this by escaping the single quote with another single quote.'),
(11, 1, 'the note field won''t update to the database and neither will open and date_closed.  The url sent to the script looked fine so the problem might be in the php script.  Possibly with checking for isset() on the params.  Although if isset() wasn''t working then the entry wouldn''t be getting updated either.', 0, '5-25-13', '5-25-13', 'Was trying to update ''note'' instead of ''notes'' field.  And for open I was using incorrect sql syntax to update multiple fields.'),
(12, 1, 'When I close a bug it should move down to the closed table and vice versa.  Currently it stays where it is until all the data is reloaded.', 1, '5-25-13', '5-25-13', 'detach the node and then prepend it to the closed table.'),
(13, 1, 'When a new entry is added I need to set it to editable and also set the id given to it by the database.  Currently new entries aren''t editable until a full data refresh.', 0, '5-25-13', '5-25-13', 'The problem isn''t setting the entry to ''editable'' but that the click event is only added during loadData(). if I set the click event in each of the insertEntry functions click will be enabled for new entries. This is where it should be. As for the id, I''m going to have to change save_entry.php so that it returns the id of the new entry.'),
(14, 2, 'On the product detail page, when there are more than two additional product thumbs, the third thumbnail does not line up with the thumbnail above it on the left side.', 0, '5-25-13', '5-25-13', 'the original style.css was setting the margin to 0 on the li:last-child in the group.  Removed that and now they all line up.  Also changed the images to display: inline-block instead of float: left. same effect either way though a few lines less of code since I could remove the clear left and the li   li selector.'),
(16, 3, 'The menu bar does not center and given that there can be a variable number of categories in the menu, setting the margin to center it isn''t an option (unless I can use jQuery to figure calculate the margin based on the length of the menu after its constructed).', 0, '5-29-13', '5-29-13', 'if the menu is in its own div with nothing floating to the left or right, then setting the div''s text-align to center and setting the first ul to display: inline-block got the text to center'),
(17, 3, 'the placement of the  items in the navbar is inconsistent across browsers.  It''s off by one or two pixels, which is the same problem I was having with lining up the search box and the search button.', 0, '5-29-13', '5-29-13', 'I moved things around so this isn''t a problem anymore.  I want to keep the first theme somewhat simple.  But I''ll have to figure this out at some point.'),
(18, 3, 'The products aren''t displaying as I expect them to.  I should just start the product list styling from scratch.', 0, '5-29-13', '5-29-13', ''),
(19, 1, 'The input box that pops up for logs is not wide enough.  Need to set the width of the input based on what type of entry of being edited, or find out if its possible to get the width of the current li or td and then set the number of cols on the input accordingly.', 1, '5-29-13', '5-29-13', ''),
(20, 3, 'search icon needs transparency added to its background.  Currently its background is white and so it only works on white backgrounds.', 0, '5-29-13', '5-29-13', ''),
(21, 3, 'background_image property in config.ru not working. Causes all styles not to load.', 0, '5-29-13', '5-29-13', 'I fixed this earlier.  Can''t remember what the fix was.  It was something trivial.  I think it had something to do with getting the url property from the json object.'),
(22, 2, 'The text for the items in the cart doesn''t line up properly.  Apply the code that I used for my big cartel theme to fix this.', 0, '5-30-13', '5-30-13', 'setting display property to inline-block on the text span.'),
(23, 3, 'Was able to center the products with text align but the final row, when there is one or two items, shouldn''t be centered.', 0, '5-31-13', '5-31-13', 'Set text-align: left specifically on the ul within section.content for products and home and that fixed the problem.  I''m not sure which text align I was talking about when describing the bug initially.'),
(24, 3, 'too much padding is still being added to the a tag that contains the logo.  About 15px on top and bottom.  There''s got to be a better way to get the image to fully display within the a tag.', 0, '6-4-13', '6-4-13', 'The problem was that the actual banner had a lot of top and bottom whitespace.'),
(25, 3, 'The footer page links aren''t centered when the social networking icons are in the footer.', 0, '6-5-13', '6-5-13', 'Moved them to the far left so it''s not an issue, but when the icons are not in the footer I should just center those items.  Will have to add a conditional to the css for the footer.'),
(26, 3, 'when there are 5 thumbs on the product page the fourth moves around depending on which thumb is selected.', 0, '6-5-13', '6-5-13', 'Changed the li that contain the thumbs from float:left to display: inline-block.  Seems to be the better method anyway.'),
(27, 3, 'Need to center the selected product image within its div on the product page.  If the width of the product image is 300 then it looks fine but when it''s less than that it looks funny because the thumbnails are centered and it is not.', 0, '6-6-13', '6-6-13', 'Just put the view div in a container div.'),
(28, 3, 'Figure out why the zoom image is sometimes smaller than the selected image (butterhome for instance).', 1, '6-6-13', '6-6-13', 'Got a little closer to solving this problem by making the max size of the image bigger and then fixing the aspect ratio. But images that are already big seem to cause problems.'),
(29, 3, 'Cursor is changing to a pointer on products page when it''s over an area of the li where the image is not displayed.', 0, '6-6-13', '6-6-13', ''),
(30, 3, 'moving the variables out of config.ru causes scope problems in that the variables assigned in the html files aren''t seen in css files other than the ones that belong to the html file.', 0, '6-7-13', '6-7-13', 'creating classes in the css and then adding them with conditionals based on variables set in the corresponding html seems to work.  Still have to do this per html page'),
(31, 3, 'Selected image on product page jumps to the left when it is first displayed because it is repositioned when the window loads.  Tried setting display to hidden on the image and the view but that didn''t work.  Try again.', 0, '6-8-13', '6-8-13', 'set visibility: hidden on the image and then changed its css properties after it is repositioned.'),
(32, 3, 'The alt text on the menu rollovers needs to be modified when the subcats are created.  Currently it is displaying the text of where it was before it was detached from the menu.', 0, '6-8-13', '6-8-13', 'This isn''t really an issue.  There is a &amp;amp because the person used an &amp; but I''m not sure if that''s my problem or something bigcartel is letting slip through.'),
(33, 1, 'Ordering not working properly in the instance of 6-10-13 immediately following 6-9-13.  The 6-10 entries are added earlier in the list.', 1, '6-10-13', '6-10-13', 'I think the problem is that it''s not making a two digit date. 6-9-13 should be 6-09-13.  I have a function that''s supposed to be doing this.'),
(34, 3, 'Products aren''t centering well... maybe move from setting the left and right margin, to using padding and setting the left and right margin to auto.', 0, '6-11-13', '6-11-13', 'This is because I needed to set text-align: left; for the section content in products.css otherwise if there are one or two image on the last row of products they will be center and look weird.'),
(35, 3, 'When the home screen loads with a slider the products image gets displayed at the top first and then the slider.... probably has something to do with starting the slider in the document.ready of the topnav.js, since the products elements are added first.  The nav buttons also flash at the top of the screen before the images load.', 1, '6-12-13', '6-12-13', 'Sort of fixed this by adding a width and height to the .product_slider class.  This should only happen in that instance since the images get loaded on document.load; however test it with images explicitly set in the html.'),
(36, 3, 'Checkout button has a look that is inconsistent with the add to bag button.', 0, '6-13-13', '6-13-13', 'In general create some a different styles of css buttons to get practice.'),
(37, 4, 'For some reason the yellow and orange circles turn white when they are returned back to their original position and color.', 0, '6-16-13', '6-16-13', 'Fixed by using the hex value for colors instead of the color names like ''yellow'' and ''orange'''),
(38, 3, 'The bottom border for the drop down menu isn''t flush on the cart page, depending on what browser I''m using.  Noticed the problem first in Firefox.  It''s not happening in Chrome.', 0, '6-19-13', '6-19-13', 'Simple matter of an imprecise style attribute in cart.css that was being applied to all the &lt;li&gt;s on the page, which includes the menu &lt;li&gt;s.  Made the style attribute more specific so it only targeted &lt;li&gt;s in the cart form.'),
(39, 3, 'Solve the problem of smaller sized images causing the product description&#x2F;price text to not line up at the bottom of the &lt;li&gt;', 0, '6-20-13', '6-20-13', 'FIXED (leaving here as reminder): made a container for the image in products.css set the container to display: table-cell and vertical-align:middle.'),
(40, 3, 'Need to add "sold out" and "coming soon" to the product description in the listings.', 0, '6-21-13', '6-21-13', ''),
(41, 3, 'product description text overlaps other things when it''s too long.  Need to calculate on the fly?', 1, '6-21-13', '6-21-13', 'Right now I just made the bottom margins bigger.  Someone would have to enter a really long description for the text to bleed into the border or other images.  Still, I need to account for that.'),
(42, 6, 'Getting a conflict&#x2F;error when I install the slider. Plus I need to include my own reference to the jquery library, which doesn''t seem right.  The slider is working but I''ll need to install it on her live site to see what functionality might be broken. This is the error: var validatorLoaded = jQuery("#fake-form").validate({});\n', 0, '6-24-13', '6-24-13', 'Seems to be fixed with the jQuery.noConflict call'),
(47, 3, 'There''s too much space between product images when product information rollovers are used.  Need to change the margins for that.', 0, '6-24-13', '6-24-13', 'Fixed this in products.js by changing li.product''s margin-bottom to 18 px within the test of each li for the existing of product_popup_info.'),
(45, 3, 'product images don''t center, which looks terrible on the ipad because there''s a bunch of white space to the right of the products.', 0, '6-24-13', '6-24-13', '*UPDATED*: setting min-width to same size as max-width (950). This also solves the weirdness on the cart page.  However, shrinking your web browser hides part of the page once it gets below this level.\n\nOne possible hack is to change text-align to center in the containing &lt;ul&gt; when the window is resized.  I could put this in products.js. I did this and copied it to the googledrive so it''s live.  Until I think of a better, less hacky solution.&lt;&#x2F;ul&gt;'),
(46, 3, 'Red sale tag and product description rollover does not stay on the image when the window is resized.', 1, '6-24-13', '6-24-13', 'luckily this was only a matter of adding position:relative to the product &lt;li&gt;s.  I remember removing that before because I thought I didn''t need it but obviously I did.'),
(48, 3, 'The ipad should be able to display three or four images across but in both instances the 3rd or 4th product is wrapping so I''m only getting 2 or 3 products per row. ', 0, '6-25-13', '6-25-13', 'It looks like setting the min-width in body to the same size as the max-with now displays 3 or 4 items per row without wrapping.  Needs further investigation though.  Plus there should be a more elegant way to handle this.'),
(49, 3, 'resizing the window when on product.html causes the zoom box to fall out of position.  Need to recalculate the window offset on the image zoom if the window is resized.', 0, '6-25-13', '6-25-13', 'Changing the global view offset on window resize.'),
(50, 3, 'The hover for products is inconsistent.  When you rollover the product name and price only the text fades and not the image.  I noticed that, even though I''m wrapping the image and description in an href, the size of the link target doesn''t extend up to the top of the image.  I think this may have something to do with using a table cell to get the images to center vertically.', 1, '7-1-13', '7-1-13', ''),
(51, 8, 'Figure out what''s going on with the font-family set in the css.  Lobster Two looks good in cursive but not otherwise; however, on Internet explorer, cursive fonts show up really tiny.', 1, '7-6-13', '7-6-13', 'Changing the config file or was it the json file seemed to remove cursive.  Need to figure out what''s going on there as well.'),
(52, 3, 'On paginated pages when there is only one row of products the page numbers are in the middle of the page far away from the footer because of min-width set on the content.', 1, '7-7-13', '7-7-13', ''),
(53, 5, 'new bug', 1, '7-30-13', '', ''),
(54, 5, 'another', 1, '7-30-13', '', 'andd note'),
(55, 65, 'new bug for new project', 0, '7-30-13', '', ''),
(56, 67, 'first bug', 0, '7-30-13', '', 'This bug is closed.'),
(57, 66, 'bug', 0, '7-30-13', '', ''),
(58, 66, 'another one ', 1, '7-30-13', '', 'and this'),
(59, 65, 'This is a bug', 1, '7-30-13', '', 'This is a note'),
(60, 67, 'Yet another bug.', 1, '7-30-13', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `project_logs`
--

CREATE TABLE IF NOT EXISTS `project_logs` (
  `project_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` text NOT NULL,
  `entry_text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=219 ;

--
-- Dumping data for table `project_logs`
--

INSERT INTO `project_logs` (`project_id`, `id`, `date`, `entry_text`) VALUES
(1, 1, '4-27-13', 'Just checked and setting the margin property to inherit has the same effect as setting the margin to 0 on the h1 and p elements '),
(1, 2, '4-27-13', 'got rid of the rest of the space between the header and the nav by setting the margins on the ul element in nav.'),
(1, 3, '4-19-13', 'Begin'),
(1, 5, '4-27-13', 'Was able to remove most of the excess margin space by setting the margins on the h1 element in the header and the p element in the footer to 0 top and bottom. Seems like it shouldn''t work that way.  Why aren''t those block elements inheriting the margin properties from their parent?'),
(1, 8, '4-22-13', 'The header and the footer have about 10px of margin on the top and bottom that I can''t remove.  I moved the nav element above the header and noticed that it doesn''t have any margin above it.  The headers within the log entries also seem to have 10px of top and bottom margin.  Seems like maybe an automatic margin is being applied at some point and that I need to figure out which element has this margin set automatically so I can set it to zero.'),
(3, 26, '5-22-13', 'Having trouble with a div set to margin: 0 auto, which takes the width of the entire body.  And placing a menu within that div that needs to be centered.  Setting the width of the div to the size of the menu will center it.  But since the menu can change in size that is not tenable.  Problem might be with the menu code and the float: left assigned to the li tag.'),
(1, 10, '4-25-13', 'Create a log app that will automate the writing of these entries using javascript and json.\r\nCreate an entry object that stores Date, Entry and Status (Open and Closed)\r\nWhen the Entry object is retrieved group all items by date.\r\nEach entry should have the ability to be closed. Have a radio button popup when an entry is hovered over.'),
(1, 11, '4-29-13', 'show or hide a page based on tab selection. Create an array of .tabPages and use the index of the selected tab to retrieve a .tabPage object from the array.'),
(1, 23, '5-20-13', 'Saving and loading data for logs, bugs and specs is functional with a few areas that need more polish.'),
(2, 24, '5-20-13', 'Finished top navigation bar, pull down menu, fancybox support and other small addition a few days ago.'),
(1, 13, '5-06-13', 'For the specs tab page, create a list ordered by priority and add the ability to change the priority of a spec within the pane. An up and down arrow next to each item when it''s selected along with a box to move the item to a specific spot somewhere else on the list.'),
(1, 14, '5-17-13', 'logs tab is now populated entirely from a MySQL db using jquery, php and json.'),
(1, 15, '5-17-13', 'changed the date creation string to prepend a 0 to all 1 digit days to fix ordering in database.'),
(1, 19, '5-17-13', 'Added the ability to create multiple projects, each with their own logs, bugs and specs data.'),
(2, 44, '5-22-13', 'Removed the top border from the products page by adding #product_page #content {margin-top: 0px} in the css in the bigcartel customize section.  A top border is also being set on contact and cart. I left those intact.'),
(1, 45, '5-23-13', 'added a jquery ui modal dialog box for login. I''ll probably go back and see if I can style it to make it look better.  Also see if it''s more convenient than using my own controls as far as styling goes.'),
(1, 48, '5-23-13', 'Can now add tags and single quotes to the database via the escapeHtml function.'),
(1, 50, '5-23-13', 'Added a table to the bugs tab.'),
(1, 51, '5-24-13', 'Made &lt;li&gt; elements editable on click.  And then updated the text of the changed id in the database.'),
(1, 52, '5-24-13', 'Didn''t take much work to make the elements in the other tabs editable and to get them to save to the database, because the initial code was extensible, which is a good sign that this is all coming back to me.'),
(1, 53, '5-25-13', 'Added updates for bug notes and for closing bugs.'),
(2, 54, '5-26-13', 'code to change links in the footer:\n#site_footer footer ul {\n    background-color: #F2EAEA;\n    border-bottom: 4px solid #F2EAEA;\n    border-top: 4px solid #F2EAEA;\n    font-family: helvetica;\n}'),
(1, 55, '5-26-13', 'Went back to my original login box. Still needs styling work.'),
(2, 56, '5-27-13', 'Added pink border around the left, right and bottom of the pulldown menu.'),
(1, 70, '5-27-13', 'Added the ability to edit a newly created entry.  The only way I could get the id out of the json object was to use the each() method.  If I just used json.newEntry[''id''] or json.newEntry.id the id portion of each of those would be undefined.  There''s something I''m not understanding about those objects.'),
(3, 71, '5-27-13', 'created the top nav bar with the pull down menu in the center. Needs a lot of styling.'),
(3, 72, '5-29-13', 'Created a footer and added an option to add the social networking icons to either the top or bottom of the page.'),
(1, 73, '5-29-13', 'added more styling and functionality to the login form.  Now it slides up and down under any circumstances, and if the login fails an alert triggers and the login form stays open.'),
(3, 74, '5-29-13', 'was able to get the menu to center by setting text-align: center; in the div that contained it and setting display: inline-block; on the first ul of the menu that has an id of #jsddm.'),
(3, 75, '5-29-13', 'Added the UO background to my body. I should think about trying to design some ambient graphic.'),
(3, 76, '5-29-13', 'The header is in a separate div beneath the top nav div that contains the floated left search and the floated right icons, however unless I add 35px of padding to the top of the header''s div, the text won''t center because it seems to get caught up in the topnav''s flow (or lack thereof).  Not sure why, just that adding some top padding got the header centered again.'),
(2, 77, '5-30-13', 'Added .09 opacity to the pulldown menu.'),
(2, 78, '5-30-13', 'Fixed the menu centering issue so that I no longer have to change the padding when another item is added to the main menu.'),
(2, 79, '5-30-13', 'Made the "number of items in the cart" text line up with the bag by setting its display type to inline-block and then adjusting its top and bottom padding.'),
(3, 80, '5-30-13', 'added a drop shadow to the menu pulldown and removed the border.  Looks better to me but check what other sites are doing to see if this is overkill. Noticed UO is just doing a bottom drop shadow on their pulldown.'),
(2, 81, '5-30-13', 'There was 60px of bottom padding between the menu and the products, which was too much space, so I reduced it to 25px. The spacing is slightly different between the home page, products page and a single product''s page.  This probably has something to do with the the top padding set for each of those pages.'),
(3, 82, '5-31-13', 'Created the subcategory menu items by matching a word at the end of a category name.  So if the user creates a main category of "cases", all of the categories they''d want as a sub category of cases would have to have "_case" appended to the end of the category name.'),
(3, 83, '5-30-13', 'Added hover for products.  Looks fine but might need a little tweaking.'),
(1, 84, '5-31-13', 'Method for clearing floats that is purportedly better than using "clear" and overflow:hidden.  Must be applied to all elements containing floats. "cf" stands for clearfix.\n&#x2F;* For modern browsers *&#x2F; \n  .cf:before, \n  .cf:after { \n  	content:""; \n  	display:table; \n	}	\n  .cf:after { \n  	clear:both; 			\n        } \n  &#x2F;* For IE 6&#x2F;7 (triggers hasLayout)  *&#x2F; \n  .cf { \n    *zoom:1;\n    }'),
(3, 85, '6-01-13', 'Added a red tag to sale items.'),
(3, 86, '6-01-13', 'messed around with creating backgrounds in photoshop.'),
(3, 87, '6-01-13', 'Fixed various centering issues. Positioning is the biggest bitch of all in CSS but I''m slowly getting the hang of it.'),
(3, 88, '6-02-13', 'started styling the product page.'),
(3, 89, '6-02-13', 'Added a slidedown animation to the pulldown menus. Took longer than expected because I didn''t know how to deal with the animation queue.  I still don''t really know how to use the queue functionality but putting in a stop() call chained before the slide fixed the crazy bubbling that would happen when a user quickly hovers over a bunch of main menu items.'),
(3, 90, '6-02-13', 'Added a hover zoom to the product page for the selected image.'),
(3, 91, '6-05-13', 'In firebug, notice how adding padding to the a tag with the mail icon in it won''t effect the overall size or padding of the li tag that contains it.'),
(3, 92, '6-06-13', 'Added three sets of social media icons.  The variable changes the path where the images are stores relative to the root directory.'),
(3, 93, '6-06-13', 'Fixed the hover problem on product images that happened when mousing over the popup info by including "pointer-events: none" to the product_popup_info class.'),
(3, 94, '6-06-13', 'Made a css sprite out of the twitter icon and cleaned up some of the weird padding things I was doing to get the images to display, when all I had to do was set the width and height of the div so that it is the same as the image size. '),
(3, 95, '6-07-13', 'started moving variables into the actual html.'),
(3, 96, '6-07-13', 'Trying to use bigcartel api to change menus. Not sure I need this but just saving it here anyway...\n&lt;!--            \n        {% for category in categories.active %}\n            &lt;li&gt;{{ category | link_to }}&lt;&#x2F;li&gt;\n            {% for sub_category in categories.active %}\n                &lt;ul&gt;\n                    {% assign sub_cat = '''' %}\n                    {% assign sub_cat_length = 0 %}\n                    {{sub_cat | append: sub_category, '' -'' }}\n                    {{ sub_cat_length | size: sub_cat %}\n                    {% if sub_category.name == (category   " -")\n                        &lt;li&gt;{{ sub_category | link_to }}&lt;&#x2F;li&gt;\n                    {% endfor %}\n                &lt;&#x2F;ul&gt;\n            {% endfor %}\n        {% endfor %}\n--&gt;'),
(3, 97, '6-08-13', 'automated the process of adding sub-categories using what other theme developers seem to be doing which is adding the sub-category name to the category name and separating it with '' - ''.'),
(3, 98, '6-08-13', 'Added 4 items per row.'),
(3, 99, '6-08-13', 'Removed pagination from the products page and just load all of that categories items.'),
(3, 100, '6-09-13', 'Started setting colors and fonts via the config.ru. Wasn''t as laborious as I thought it would be.'),
(3, 101, '6-10-13', 'added an effect that makes all of the product images fade in at different intervals when the page loads. Needs more testing though because there was lockups when I tried to fade in the product info div and the on sale div, so for now I''m just showing those instead of fading them in.'),
(3, 102, '6-10-13', 'Got the zoom to work better for smaller images but now I have a slight issue with images that are already big.  I need the size of the zoom clip to always be the same size and for that size to fit within the page view.'),
(1, 104, '6-10-13', 'Moved app to new server.'),
(3, 105, '6-10-13', 'Added a slider yesterday.  Should be easy to setup in the pages to create multiple lookbooks.'),
(3, 106, '6-10-13', 'fixed the spacing of the cart items so they line up.  Whoever did the initial markup on those did a horrible job.'),
(3, 109, '6-11-13', 'uploaded site to big cartel. Not a lot of surprises so far.  Found I was using incorrect theme variables in some places but other than that it''s going smoothly.'),
(3, 108, '6-11-13', 'created gregscharf.bigcartel.com'),
(2, 110, '6-11-13', 'moved my menu over to Tressa''s site.  Ran into some problems with css specificity due to a lot of ids being set in the original design and also my use of them as well.  Now I know first hand that using ids is a horrible idea.'),
(2, 111, '6-11-13', 'Next time I make any changes I need to download the entire site and edit that because all the changes I made weren''t also made on the copies I have on my hard drive.'),
(2, 112, '6-11-13', 'Fixed footer links with an override in style-mod.css.  Had to explicitly set the link and rollover colors along with adding the color transition to a and :hover.  If the colors change in the bigcartel settings area they will not get applied to the footer... and probably a few other places as well.'),
(3, 113, '6-12-13', 'Had trouble with connecting to my server this morning.  Might have to go with some alternate method of hosting my images and javascripts.  Maybe try google drive.'),
(3, 114, '6-12-13', 'Added the ability to pull product images into the image slider.  But 1000x1000 is kind of big and 300x300 is too small. So setting the width and height seems necessary.  Only problem is that someone might''ve used an odd dimension.  I suppose I could apply my aspect ratio function to the images and set them to a reasonable width and height to where they''re not distorted.'),
(3, 115, '6-12-13', 'Made an Etsy shop.  Seems the way to go because of the cheap price and the digital download.'),
(3, 116, '6-13-13', 'Fixed the weird dotted border that was showing up on selected product thumbs by removing the dotted border property set in normalize.css.  Also made the border just go around the image instead of the entire li, which was causing a gap to show between the image and the border.'),
(3, 117, '6-16-13', 'Made an option to set the width and height of the bigcartel product images in the slider.  The fact that the images can be of variable size sort of creates a problem with distortion even though I am scaling to correct aspect ratio (not sure if that''s 100% working though).'),
(4, 118, '6-16-13', 'Designed a small layout with page centered content, which I thought would look good when there is very little content.'),
(4, 119, '6-16-13', 'Made a vertical menu with circles for each item that when clicked will slide up to the top and then over into the content area, at which point they will transform into a menu header.'),
(4, 120, '6-16-13', 'Finished up the menu by polishing the animations and adding a little more color.  Thinking about turning this into a plugin.'),
(4, 121, '6-17-13', 'Created an email submission form for the contact page along with the php script for the server.'),
(1, 122, '6-17-13', 'icon set:\nhttps:&#x2F;&#x2F;creativemarket.com&#x2F;benbate&#x2F;2830-Cuppa-Personal-Site-%28HTMLCSS%29&#x2F;live-preview'),
(5, 123, '6-18-13', 'Converted the bubble navigation design I was making for my home page over to BigCartel.'),
(6, 124, '6-19-13', 'Potential job to install image slider.'),
(6, 125, '6-19-13', 'I''m downloading the entire site in order to integrate the flexslider into the running html.'),
(6, 126, '6-19-13', 'Installing seems easy enough.  The code is contained within layout.html (css, javascript, and flexslider init) and home.html (the actual flexslider html with links to the images). '),
(2, 127, '6-19-13', 'Was going to add the image slider today to test how long it would take to install on someone else''s setup but instead installed it on the bc_two theme I''m working on.'),
(3, 128, '6-19-13', 'Changed the bag icon, added My Bag text to the top nav bar and made the text a little bigger.  I had to restructure the divs a bit but it looks better now.'),
(3, 129, '6-19-13', 'removed the annoying tooltip popups from the pulldown menu items.  Have to push a new version of the scripts.js to the server now.'),
(5, 130, '6-19-13', 'Yesterday I wrote code to load all of the products when the page first loads and then I''m parsing the returned JSON object to put the products into their respective category pages.  Seems more efficient than making a server call every time a category is loaded.  This came out of necessity since the Product.findAll in the dugway api wasn''t working with parameters.'),
(7, 131, '6-20-13', 'Sold my first bc_fawn theme.'),
(7, 132, '6-20-13', 'Had to completely remove the vertical-align property from the li tags in products.css. Setting it to "bottom" had no effect.  The products were vertically aligning to the top along with their name and price, which didn''t look good.  Now they align to the bottom.  And when rollover info is turned on they align to the top again for some reason.  Really need to look into why that is.'),
(7, 133, '6-20-13', 'Fixed a problem with the background image being applied to the html and not the body.  It was because I was setting the body background color when an image was set in html.  If I don''t set the background color then the image also fills up the area within the body tag.  Need to move that change to the main theme because right now it''s only in the linenandblue code.'),
(3, 134, '6-20-13', 'moved the flexslider css and javascript into styles.css and scripts.js.  Now if any changes need to be made to the flexslider they can be done within the design area of BigCartel because the flexslider css will be in the main css.'),
(3, 135, '6-20-13', 'Removing vertical-align: top from the &lt;li&gt;s for products creates another set of problems when the product description and price info is real long.  Then the images don''t line up along the bottom row.'),
(7, 136, '6-20-13', 'Fixed the alignment of the product description and price in relation to the product images and uploaded the fixes to the linenandblue shop.'),
(7, 137, '6-20-13', 'I changed the code in bc_fawn and then moved it over to linenandblue directory so both directories are currently in sync.'),
(3, 138, '6-20-13', 'Fixed the image and product description alignment problem with the products on the products and home page.'),
(3, 139, '6-21-13', 'Started hosting the files on googledrive'),
(3, 140, '6-21-13', 'Added the new code to my bigcartel theme.  Realized that I need BC''s javascript api for the perma-link slider so good thing since I removed the loading of that api earlier.'),
(7, 141, '6-21-13', 'Updated bc_fawn and updated the linenandblue BC store.  Code for linenandblue on my local drive is out of date.'),
(7, 142, '6-21-13', 'Just pushed the cart code onto the store but there are no products available to add to the cart so I couldn''t really see if it worked.  Hopefully the results will be the same as my testing on my own bigcartel shop.'),
(3, 143, '6-22-13', 'Spent most of last night frantically adding shipping to the cart page.'),
(3, 144, '6-22-13', 'Made the buttons uniform across the site and also allowed the button and button_hover variables from Luna to affect the buttons.'),
(7, 145, '6-22-13', 'Did another code push for buttons, discounts and the cart summary.'),
(3, 146, '6-23-13', 'Added support for promotions and discounts.  Still need to test some of the other variables involved with that.'),
(7, 147, '6-23-13', 'Changed the css on the site for the cart menu fix.'),
(3, 148, '6-23-13', 'Made the cart summary page look a lot nicer.  Made sure all the spacing was correct under all variable conditions.'),
(3, 149, '6-23-13', 'Added luna contact html and css to my own code.  Didn''t seem to give me much but centering though.  And there''s a lot of css that goes with contact.html.'),
(3, 150, '6-23-13', 'I feel like I finally have a release zip.  I should name it 1.0 instead of 0.0.1 or whatever it is now.'),
(3, 151, '6-23-13', 'Made even more modifications to the cart page. Now it looks really good.'),
(3, 152, '6-23-13', 'started etsy search ads.  Remember to stop by the end of the week if it doesn''t lead to any sales.'),
(7, 153, '6-24-13', 'Just pushed the absolute newest cart code and contact code to the server. Can''t help but think there was something I needed to ask her before I did this. Hope not.'),
(6, 154, '6-24-13', 'She just placed an order.  I should use the site I downloaded from her to see if I can get this running.'),
(6, 155, '6-24-13', 'Was able to get the code working in the downloaded page.  Had a bit of a problem with a prototype.js and jquery conflict but found some code that deals with that problem'),
(3, 156, '6-24-13', 'Fixed some bugs today.  Saw that the sale tags and product info were floating off the images when the window gets resized. Fixed that with position: relative.'),
(3, 157, '6-24-13', 'Tried unsuccessfully to get the product images centered.  text-align: center; centers the images but then the bottom images get centered too and that looks weird.'),
(3, 158, '6-25-13', 'Wasn''t setting min-width and it was causing some strange problems when the screen was completely shrunk.  Although why would anyone want their screen that small. Need to try this on my phone.'),
(6, 159, '6-25-13', 'Finished adding the slider to regal rose.  Went smoothly enough.  The only external files I''m hosting are the javascript file and the nav image.'),
(7, 160, '6-25-13', 'Added min-width to the body tag of her css this morning.'),
(7, 161, '6-25-13', 'I also made some changes to product.js yesterday and update the file on my googledrive.  One was for decreasing the size of the bottom margins when product_popup_info is added, and the other was a hack that adds text-align: center to the products ul when the screen is less than 1000 or so pixels.  I also do this when the window is resized.'),
(3, 162, '6-25-13', 'Commented the text-align on window resize change out of the js file because min-width negates it''s use and I don''t want unnecessary resize calls happening if they don''t need to.'),
(3, 163, '6-25-13', 'Fixed a product zoom bug that occurred when the window is resized.  I change the global view offset when the window is resized now.  Change in js.'),
(3, 164, '6-25-13', 'Fixed the line-height on the remove product button so that it matches the width and height and is therefore centered within the circle.'),
(6, 165, '6-25-13', 'Paid to fix the missing buttons on the product page.  Was simply a matter of switching to the new way that BC references images.'),
(3, 166, '6-26-13', 'Added facebook, twitter and pinterest support on the product pages.'),
(3, 167, '6-26-13', 'changed some of the margins in the top nav: scooted the media icons closer to the bag by 15px and also shaved a couple pixels off the top-margin, though this is something that will be dependent on the font that has been chosen.  Might need to deal with this.'),
(6, 168, '6-26-13', 'Adding height:auto to .flexslider will make the bottom border move up to the bottom of the image.  Setting that value to the same size as the image caused the border to move down.'),
(6, 169, '6-27-13', 'Check specs for adding images of smaller size to a group of bigger images.'),
(7, 170, '6-27-13', 'Added Brands to her footer and fixing other issues that I wasn''t dealing with properly in my code such as the Artist&#x2F;Brand name on the product page and not allowing someone to checkout if they try to select a different country.'),
(3, 171, '6-27-13', 'I''m now preventing the user from checking out if they have an invalid country selected on the cart page.  Linenandblue pointed this out.'),
(3, 172, '6-27-13', 'Fixed the text size of the Artist text on the product page.  It was displaying as an h4 right under the product name and now it''s regular text at the end of the product description.'),
(3, 173, '6-28-13', 'When I added copyright and my link to the bottom of the page I noticed that the Page links were not centered correctly.  Fixed this by adding an equal amount of left and right margin to the li''s and also to the containing ul.'),
(3, 174, '6-28-13', 'Found and fixed a bug with the margins between the discount entry input and the Discount label.'),
(8, 175, '6-28-13', 'Created the styling and layout of the site header, which contains most of the site''s functionality.'),
(8, 176, '6-28-13', 'Tried getting the ul and li''s of the product images to center via margins, but I''m still having no luck.  I need to be able to do this without using text-align center so that the bottom row of products won''t look weird.  I should take another look at Luna.'),
(3, 177, '6-29-13', 'Fixed the darkbag icon not having transparency set in all parts of the image. '),
(3, 178, '6-29-13', 'Added more meta keywords. Just like Luna.'),
(3, 179, '6-29-13', 'Figured out that if I want one of the settings in config.ru to work then it also needs to exist in settings.json.'),
(3, 186, '7-1-13', 'Added pagination onto the products pages.  I''m pretty sure there was no way to display more than the products per one page before.  Luckily Luna''s css and html easily and quickly fixed the problem.'),
(9, 185, '7-1-13', 'Installed theme and made some minor adjustments to language and header image.'),
(5, 182, '6-30-13', 'Added the ability to switch between a nav circle and one of the page buttons at the top of the page.'),
(5, 184, '7-1-13', 'Got the product page and cart page to open up in a fancybox.'),
(10, 187, '7-2-13', 'Installed theme.'),
(9, 188, '7-2-13', 'Looking into making the image sizes bigger.'),
(3, 189, '7-3-13', 'Added a variable for turning off the link to my site.'),
(3, 190, '7-3-13', 'Added 4 pixels of margin to the 4 per row display of products as they didn''t appear completely centered.'),
(5, 191, '7-3-13', 'Everything is up and working.  This theme probably won''t work with anyone else''s data since the margins and text need to be so precise in order for it to look right.  Plus there are a lot of other things that needed to be hard coded.'),
(3, 192, '7-4-13', 'Finally working on revising the documentation in the html files as well as creating a separate document for instructions.'),
(3, 193, '7-4-13', 'I''m going to revisit using permalinks on the home page slider after I''m done with the instructions.'),
(3, 194, '7-4-13', 'Adding some new code to make permalinks work much much better.  Hopefully that will handle all scenarios. '),
(3, 195, '7-4-13', 'Found out I was using theme.text_color instead of theme.text in a few places.  Fixed that and made the changes on all four sites.  Have to be more careful of such things in the future.'),
(5, 196, '7-5-13', 'Made the Contact page more presentable.'),
(5, 197, '7-5-13', 'Added a list of demos to the main content area when the main menu item "Demos" is clicked on.'),
(8, 198, '7-5-13', 'Added Nivo slider. And after I added it I''m not really sure what more I got than I was already getting with the flexslider.  '),
(8, 199, '7-5-13', 'Changed around the layout quite a bit.  Seems like the header&#x2F;layout is ultimately done.  I probably just need to finalize a few things and maybe change up the product page a bit.  Maybe move shipping and discount to different places within the cart.'),
(8, 200, '7-6-13', 'Changed the name from Ocelot to semi-clean slate.'),
(8, 201, '7-6-13', 'Moved the header over to the left.'),
(8, 202, '7-6-13', 'Added options for 5, 4 or 3 items per row.'),
(3, 203, '7-7-13', 'Going to change the image size to 225x225 for 4 products per row display.  Will need to make a fawn 1.1 directory for the javascript files.'),
(3, 204, '7-7-13', 'To upgrade someone to the 1.1 javascript they will need to take the changes made to products listings in home.html, products.html and products.css.  And then in layout.html just point to the javascript file at fawn&#x2F;1.1.'),
(11, 205, '7-9-13', 'Took me quite a few hours to get apache, php and mysql setup on my computer but now that I have I can get started on designing a theme that Tressa can use and that hopefully I can sell or at least ask donations for.'),
(11, 206, '7-9-13', 'Made a header and added my pulldown menu to it.'),
(11, 207, '7-9-13', 'Having trouble with some of this php code not doing what I expect it to do.'),
(5, 208, '7-11-13', 'Working on using ajax to submit the contact form.  At first it seemed like an easy thing that was working but now it''s giving me trouble.'),
(5, 209, '7-11-13', 'Finally got the form to submit via ajax as well as parsing the page for errors to display in an error window... or displaying a success message.  Works pretty good but should probably be prettied up a bit.'),
(67, 216, '7-30-13', 'first entry'),
(3, 210, '7-30-13', 'new log'),
(3, 211, '7-30-13', 'test  klkk'),
(61, 212, '7-30-13', 'asadasdas'),
(62, 213, '7-30-13', 'asdsadad'),
(65, 214, '7-30-13', 'Logs are ordered by date.'),
(66, 215, '7-30-13', 'This is an example of a log entry.  Edit in place and the entry is saved when the text area loses focus.'),
(3, 217, '7-30-13', 'This is an example of a longer text log.'),
(65, 218, '7-30-13', 'The editor for new entries is context sensitive and will open up the relevant dialog based on the tab that is selected.');

-- --------------------------------------------------------

--
-- Table structure for table `project_specs`
--

CREATE TABLE IF NOT EXISTS `project_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `spec` text NOT NULL,
  `open` tinyint(1) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=93 ;

--
-- Dumping data for table `project_specs`
--

INSERT INTO `project_specs` (`id`, `project_id`, `spec`, `open`, `notes`) VALUES
(1, 1, 'Create an icon that will list the total number of open bug and spec entries and place it in the upper right corner of each tab.', 1, ''),
(2, 1, 'The bugs page should display two tables, one for open bugs and one for closed.\nSpecs is fine as a list with the exception of ordering by priority and displaying the list as ordered.', 0, 'Made the specs page similar to the bugs page.'),
(3, 2, 'Create or find a widget that displays a carousel of images for the home page.', 0, ''),
(4, 1, 'Create a pulldown menu that can be used to create an entirely new project and also the ability to add logs, bugs and specs.', 1, ''),
(5, 2, 'Make the size selection pulldown look nicer.', 1, ''),
(6, 1, 'Make all items clickable.  On a click event display a text area or a pull down for bool values.  Edit the entry in the database once the field loses focus and some change has been made.', 0, 'All items are editable and can now be updated in the database.'),
(7, 2, 'Change the topnav icons so that they start faded and then become fully opaque on hover.  Switch the opacity values in .fade and .fade:hover.', 0, 'Doesn''t want this done but I did add it to my test theme.'),
(8, 2, 'For the links in the footer add a pink background or border and changed the font to Helvetica.  Maybe go with a top and bottom border that is thick enough to butt up against the links, the center being white.', 1, ''),
(9, 2, 'figure out a way to center the menu based on the size of the menu so I don''t have to change the left-padding every time an item is added or the font is changed.', 0, 'Set display to inline-block on #jsddm. The div that the menu is in is set to text-align: center;'),
(13, 1, 'In the bugs and specs table the open column should have a button for "close" on the open table and "reopen" on the closed table.  Maybe hide the button so that it is only visible when the row is hovered over.  In that case the open column would be eliminated altogether.  Maybe have a similar effect for li tags in case I want to delete them from the database completely.', 1, ''),
(14, 1, 'Check on the usefulness of creating an entry class with the data for each entry and the methods that manipulate an entry''s data.  Also create inherited classes (prototypal) for bug and spec entries.', 1, ''),
(15, 3, 'When all the products for a category are displayed show them in an "amazon" style list with an add to cart button next to each product.  Clicking on the thumbnail or the item description will open up a more detailed product page.', 0, 'Decided not to do this for the first theme... maybe I''ll add something like this in a future theme.'),
(16, 1, 'add a :hover property to all of the editable elements so that the cursor changes to a pointer and the element gets a box shadow.', 0, 'Looks good over items with borders but not as good over the li elements that have no borders.  Moving the drop shadow to the left on the li''s does help though.'),
(17, 1, 'Specs tab needs a table to hold the spec and spec note and a button to mark the item as completed.  Instead of creating two tables maybe just move the completed items to the bottom of the list and change their text color or add some diagonal text that is mostly transparent and reads completed.', 0, 'Finished except for the button or pulldown to change the status to open or completed, which has it''s own ticket number.  Right now I can just change the value to 0 or 1 for closed and open.'),
(18, 1, 'See if moving the header text out of the header tag and into an h1 tag with a style of text-align center, along with other styles will fix the header moving around and not staying center.  If I clear:right the h1 tag the heading will center but it will move down below the login and projects select.  The project select is what is moving the h1 to the left.', 0, ''),
(19, 3, 'Put the store title at the very top of the page. Below that have a nav bar. A 4 pixel top and bottom border with slight box shadow and some color in between.  Search on the left, menu in the middle and social networking icons on the right. Minus the borders it should be about 30 pixels high.', 0, 'went with the more simple search and cart on top, store name below that and menu below that.'),
(20, 3, 'The main page should have a carousel of products that dissolve in and out of each other.  Make it flexible enough to allow for it to be loaded with a group of images or products, etc   Below the carousel maybe have the thumbs for each item in the carousel. This should also be an option to turn on or off. There''s probably a widget out there that already does this.', 0, 'added a slider.'),
(21, 2, 'Make the background of the pull down menu slightly transparent.', 0, 'Added a .09 opacity just like my big cartel test theme.'),
(22, 3, 'try adding the shopping bag or cart image to the background of the &lt;a&gt; tag of the cart and set its position to left center. see page 321 css3 the missing manual.', 0, 'Didn''t seem necessary, but I did change the display type of the spanned text to inline-block and so was able to set the padding on the top and get better control of the placement of the text next to the bag image.'),
(23, 1, 'turn the write and delete edit buttons into a css sprite to get some practice with those, and because it seems like a good candidate for being turned into a css sprite.', 0, 'closed'),
(24, 3, 'Add newsletter support.', 1, ''),
(25, 3, 'Customization: custom colored social networking icons -  $15.', 1, ''),
(26, 2, 'Ask about adding a drop shadow to the menu pulldown similar to my test theme.', 1, ''),
(27, 2, 'Said she wanted a fav icon or something add to the home page (ipad?)', 1, ''),
(28, 3, 'Think about making contact a popup or slide up dialog box. it would have to be modal though since it''d be weird if that stuck around while the user was clicking around the page.', 0, 'Noticed that the TonkaPark contact works this way. Not happening for this thing.  Maybe the next one.'),
(29, 3, 'Sale items could have a diagonally skewed red tag&#x2F;banner with black text in the upper right corner of the product picture.', 0, 'Diagonal didn''t work because it created a box that took up the space of the entire diagonally skewed color block, so I just made a square tag and put it at the top of the photo.'),
(30, 3, 'What about main menu categories that don''t have any subcategories?  I could use the * instead of the _ to indicate that the item is a main category.\nOptions:\n1)  "add all categories to the main menu". Clearly this would be a bad idea if there are more than 7 or 8 categories. If they do this remove the "All" pull down.\n2)  If you have a lot of categories create subcategories.\n    a)  to move a product category to the main menu put an * in front of it.\n    b)  create a main category that will have subcategories (if I can''t do this in customization settings, then I''ll have to do it at the top of layout.html with variables)\n3) "Info" will contain a pulldown for all their pages.\nWhat happens when they click a user created main category?  Typically these aren''t linked to any pages as they are created in the theme customization.  How would I load all the items for every sub category under that category?', 1, 'found a theme that had '' - '' subcategories added so was able to write a jquery function to create the menus.'),
(31, 2, 'I could add my jquery code that takes items from the products menu and places them on the main menu based on a delimiter (*, _) and category name.  Then I''d only have to add the main categories to the html.', 0, 'I did this differently. It''s currently working in my test theme.'),
(32, 1, 'Look into ways of making the page load more efficient e.g. instead of calling insertEntry for each item that needs to be created, which will trigger x number of appends, construct a large string that will contain all of the item tags to be inserted and then do a single append.', 0, 'about to open and then changed to close'),
(33, 1, 'Think about using bind to pass an object literal containing a entry''s row data on an .editable click, This would save having to parse through the Dom for all the rows data. Could be faster and more efficient.', 0, 'cloed'),
(34, 3, 'On the product page create a hover effect of the primary product image that opens up a zoomed portion of the image that appears over the product details.', 0, 'Hid the product details because the image was pushing them down when it appeared.  Have to figure out how to change that'),
(35, 2, 'use background positioning for the bag icon so changing the font won''t make the number possibly overlap the bag.', 1, ''),
(36, 3, 'animate the zoomed image to open up slowy when it first displays. Maybe passing a time variable to show or maybe fade in.', 0, 'Maybe slide it over by animating its left position property, setting it to -x initially, and as it slides over slowly fade out the product detail text.'),
(37, 3, 'Test out the red sale tag on product images that are centered within the li.  Probably will be off, so do the same thing you did with the "product_popup_info".', 0, 'It was off.  I also moved all of the calculating code out of the hover and into document ready. It was unnecessary calculating the width and position of the popup every time in hover when it should only happen once when the page loads.'),
(38, 3, 'set all colors and fonts with the values from the config file.\nHow many different colors? Header, body, footer...\n', 0, 'This is done for the most part but I have to figure out what I want to do with the text_secondary and text_tertiary variables.  I was thinking of using those for the h1 tags.  That way the header can have its own font color and the product page headings for product title, sold out, etc can have their own colors. Seems like it might be confusing though if a heading is considered "secondary" or "tertiary".'),
(45, 3, 'Add "Related Products" to the bottom of the home page.', 0, 'Not sure I want to do this.'),
(39, 2, '"Info" would be a good place to add all of the page links.  This is what is happening on my current theme.', 1, ''),
(40, 3, 'Nice font for header, menus and footer... maybe couple with Arial.\n&lt;link href=''http:&#x2F;&#x2F;fonts.googleapis.com&#x2F;css?family=Fjalla One'' rel=''stylesheet'' type=''text&#x2F;css''&gt;', 0, 'Fonts are determined in Luna settings but maybe I can use this somewhere else.'),
(41, 3, 'Scale the products content div to allow for 3 or 4 products per row?  ', 0, 'All I had to do was change the loaded product image from large (300x300) to medium (175x175).  Also, force number of products per page to be divisible by the number of items per row.'),
(42, 3, 'Needs mobile functionality.', 0, ''),
(43, 2, 'Show 4 products per row.  Need to load the medium image and then set the width of the divs to 175 and probably other values in product li.', 1, ''),
(44, 3, 'Think about removing borders from menus and adding a bottom border to each li and also light up its background.', 0, ''),
(46, 3, 'Make sure the footer stays at the bottom of the page even when there is not enough content to fill the entire page.', 1, 'Set section.content to min-height: 400px but that is only going to be optimal on my particular resolution.  I should probably set min-height on content based on the size of the window.  height of footer - size of window.  I could even change this on window resize so the footer is always at the bottom of the screen.'),
(47, 3, 'Think about adding the ability to display 3 or 4 products per row.  The variable would have to be added to the css.  3 items per row would display 300x300 images 4 items would display 175x175.  The logic is in products.css currently commented out.', 0, 'Added the variable assignment in the html and just change the classes based on whether the user set the variable to 3 or 4.'),
(48, 2, 'Update menu:\nlayout.html\nmenu.css\nmenu.js\n\nChange the names of product categories.\n\n', 0, ''),
(49, 3, 'Add an assign to the homepage that allows the addition of a permalink to either products or products within a category for the slider.', 0, 'Images at 1000x1000. I might use my aspect ratio function and re-size them to a more reasonable size.'),
(50, 3, 'I need a generic directory on my server to store the images and javascripts for anyone downloading my site.', 0, ''),
(51, 3, 'Create an instruction&#x2F;read me text file.', 1, ''),
(52, 3, 'Probably need to be able to set the width and height of the images on the product slider when set from a perma-link.  The user setting the values will have to maintain aspect ratio or I suppose I could just do it myself without allowing them to set values.', 0, 'Done but needs more thorough testing.'),
(53, 4, 'Leave a blank circle where the current circular menu item just moved from. Use an inner drop shadow to make it look like a deep hole.', 0, 'Put the drop shadow on hover.'),
(54, 4, 'Create a links nav button.', 1, ''),
(55, 6, 'Put the call to create the flexslider between script tags within the head of layout.html', 1, ''),
(56, 6, 'The link to the flexslider script (    &lt;script src="http:&#x2F;&#x2F;googledrive.com&#x2F;host&#x2F;0B51UCH0yGk6FTWNWQTVUVEJ1THM" type="text&#x2F;javascript"&gt;&lt;&#x2F;script&gt;--&gt;\n) which is the minified js file, will also go in layout.html.', 1, ''),
(57, 6, 'I am hosting the Flexslider files on Google drive.  Only the javascript file needs to be hosted.', 1, ''),
(58, 6, 'The actual flexslider html code will go into home.html.', 1, ''),
(59, 6, 'Require images to be of the same size? Currently different sized images create a leftover fragment of the previous image.', 1, ''),
(60, 7, 'See what happens when the red sale tag is applied to products that are not vertically aligned to top.', 0, 'The sales tag isn''t a problem, it shows up in the image corner rather than the li corner.'),
(61, 3, 'Try moving the display:table-cell code out of the "image" containers and into the li, hopefully eliminating the need for those two div wrappers.  The only benefit here is efficiency and less clunky code.', 0, 'That didn''t work.  The display type needs to be set to inline.'),
(62, 7, 'Need to push new product listing changes to her html--\nhome.html\nproducts.html\n(scripts.js has been updated on my server)\nstyles.css', 0, ''),
(63, 7, 'switch the image reference and script reference to point the my googledrive hosted files.  styles.css will have these changes already but layout.html needs the changes.', 0, 'This is up and working.'),
(64, 7, 'Just changed the way the products fade in.  Much more efficient but since the change affects both the css and javascript I need to wait until I change her css before I can move the javascript file onto the live server.', 0, 'uploaded changes to bigcartel from bc_fawn... linenandblue on my local drive is out of date.'),
(65, 3, 'Clean up the css code for the buttons that are on the product page and the cart page.  The css code to create the look of the buttons sitewide should go into layout.css, and then the specific button styles should go in the files for their respective pages.', 0, 'Done. Also made the send button on the contact page in the same style'),
(66, 3, 'Need to add discount functionality to the cart page.', 0, ''),
(67, 7, 'Made changes to buttons on contact, product and cart that will require her to change button colors in settings.  Also handling discounts and changed the appearance of the cart summary.  Need to ask before uploading these things but I need to do this as soon as possible. Right now she just has the shipping enabled but I think it''s using the old way of the update button, which might break since I removed that code from the css.', 0, 'DONE: but with all these changes I feel like I might be forgetting something. Hopefully there''s no trouble.\nFiles: css, cart, product, contact... new .js is already on googledrive.'),
(68, 3, 'Test all of the various promotion&#x2F;discount variables.', 0, 'Did this and moved things around a bit.'),
(69, 3, 'Map out how and where to apply secondary and tertiary text colors by looking at how Luna does it. Start on the Product page, also the cart page.  I think product descriptions on the product page use text color secondary.', 0, ''),
(70, 3, 'Pretty up the contact page.', 0, 'Centered everything.  Good enough for now.'),
(71, 7, 'Need to move the new "Cart Summary" and the new Contact (that change is just centering with a heading) to the BC server.', 0, 'Done. But am I forgetting something?'),
(72, 7, 'I wanted to fix that pipe on the main menu but I feel weird about changing something she''s done. I''ll have to ask when I do another code push.', 0, 'Done while doing some other changes for her.'),
(73, 6, 'The flexslider css code will be pasted directly into the css code within BC.  Remember to change the link to the buttonnav.png in the css.', 1, ''),
(74, 6, 'The image dimensions are also set within the css.  The default is to simply accept the native image size. If different image sizes are required then I''ll need to change that.', 1, ''),
(75, 6, 'Noticed that images loading from s20.postimg.org aren''t loading. Should probably mention that to her.', 0, ''),
(76, 6, 'nivoslider seems to already be installed or at least there are references to it on her site.', 0, ''),
(77, 3, 'Add Pinterest, Facebook and twitter links to the product pages.', 0, ''),
(78, 6, '**IMPORTANT** \nTo get an image (ex: 476x600) that is not that same size as other images (ex:900x600)  to not expand to ridiculous proportions when flexslider resizes it, set its dimensions explicitly like this:\n          &lt;!--&lt;img src="http:&#x2F;&#x2F;gregscharf.com&#x2F;bigcartel&#x2F;fawn&#x2F;images&#x2F;flextest&#x2F;music&#x2F;annieclarkbw-small.jpg" style="width:476px; height:600px; "&#x2F;&gt;--&gt;\n', 1, ''),
(79, 9, 'Add new social media icons.  Look into making this a customization option for the overall theme.', 0, ''),
(80, 9, 'Get image slider to resemble this place with the images she sent me:\nhttp:&#x2F;&#x2F;lespetitsbohemes.bigcartel.com&#x2F;', 1, ''),
(81, 9, 'Header is huge.  Need to find out what she wants to do about that.', 1, ''),
(82, 10, 'Resize her images and then send them back.  What size?', 1, ''),
(83, 3, 'See what''s involved with making the 175 images into 200.', 0, 'Not possible because of potential image irregularities '),
(84, 3, 'Add a switch to choose between the zoom hover and a fancybox viewer.', 0, ''),
(85, 5, 'Try using an ajax call to send the contact form.', 0, 'This took the better part of the day.  Mostly because of updating the incorrect folder and also google drive not updating my file.'),
(86, 8, 'Think about using text-secondary and text-tertiary for the headers other than the main header. And the footer text.  Check and see what Luna is doing with those.', 1, ''),
(87, 3, 'I figured out how to make the images bigger than 175x175 on the four per row display, however it requires a bunch of changes to the code, so I was thinking of making a new directory on my google drive for fawn-1.1.  Seems like only the javascript needs to change.  Or maybe make a 1.1 directory within the javascript of the current fawn directory.', 0, 'going to edit files: products.js, utils.js, products.css, products.html, home.html.\nI can''t just change the javascript because the html needs to load in the bigger image.\n**Uploaded to Etsy; however still need to determine whether the current 4 users want this change.  Tangerinette is the one who asked for it.'),
(88, 3, 'I need to figure out how to use the biggest image for the zoom.  This will be far trickier.  Right now I''m up-scaling from 300x300 which causes blurring.  Very stupid.', 0, ''),
(89, 65, 'More text for a spec entry', 1, 'more notes'),
(90, 65, 'Clicking on the text will open an edit in place text area.', 1, 'notes,  notes, notes'),
(91, 67, 'spec', 1, ''),
(92, 66, 'spec', 1, '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
