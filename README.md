JHPopoverController
-------------------

- Author: Jon Hocking http://jonhocking.co.uk
- Email: hello@jonhocking.co.uk
- Code URL: https://github.com/jonhocking/JHPopoverController
- License: MIT (Below)
- Support: http://stackoverflow.com

<br />

A custom styled UIPopoverController replacement, drawn entirely with core graphics to keep it fast and flexible.

This project was inspired by this shot on Dribbble https://twitter.com/jon_hocking/status/187187697763360768

![Popover shown presented](http://f.cl.ly/items/1F083N1D1I2k0g3b2z1D/JHPopover_1.png)

More screen shots found here:

- http://cl.ly/FrTs
- http://cl.ly/Fs1N
- http://cl.ly/FrpF

The controller interface works in a similar way to the default UIPopoverController. There are currently a few missing features to be added in the next set of releases.
 
 

<br />

Basic Features & Road Map
---------------------------

- ARC enabled
- Retina ready drawing
- smart calculation for point when near view bounds
- can only present from the top so far (hopefully this will be changed in future releases)
- works best with fixed content but will automatically scroll if the viewcontroller's view is larger than the content size
- automatically dismisses the popover on rotation of device so avoid the presentation being 'off'. (Hopefully I can fix this in future releases as well).
- would like to add a nice way to customise the colours through the controller interface

<br />

To Use
------

The two classes you'll need are in the *JHPopoverViewController* sub folder in the Xcode project. 

Once you've included these in your project, use the view by init'ing the controller object and giving it a view controller to present.

**You should use the controller interface instead of accessing the popover view directly.**

<br />

MIT Licence
-----------

Copyright (C) 2011 Jon Hocking

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.