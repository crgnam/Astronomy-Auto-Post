This was my first time trying to image and process a comet. I definitely learned a lot and am reasonably happy with the result! This is a composite of 2 images: One where I aligned and stacked on the comet, and one where I aligned and stacked on the stars. I found that I got better results by stacking the comet in batches of every 5th image as it allowed me to better reject the stars since they weren't overlapping.

[(Original Post on Astrobin)](https://www.astrobin.com/x00qjq/)


 *** 

## Equipment: 

 - **Imaging Optics:** William Optics Redcat 51 
 - **Imaging Cameras:** ZWO ASI183MC Pro 
 - **Mounts:** Sky-Watcher Star Adventurer GTi 
 - **Filters:** 
   - Optolong L-Pro 1.25"

 - **Accessories:** 
   - ZWO ASIAIR Pro
   - ZWO EAF

 - **Software:** 
   - Adobe Lightroom
   - Pleiades Astrophoto PixInsight

 - **Guide Scope:** ZWO 30mm Mini Guider Scope
 - **Guide Cameras:** ZWO ASI120MM Mini


 *** 

## Aquisition: 

 - **Imaging Dates:** 
   - Jan. 26, 2023
 
 - **Frames:** 
   - Optolong L-Pro 1.25": 169x60"(2h 49") (gain: 111.00) -10C bin 1x1
 
 - **Total Integration Time:** 2h 49" 
 - **Darks:** 60 
 - **Flats:** 30 
 - **Dark Flats:** 60 
 - **Bortle:** 3.00 


 *** 

## Processing: 

**PixInsight:**
 - WeightedBatchPreprocessing (Calibration, Registration, and Stacking on the stars)
 - CometAlignment + ImageIntegration (Aligning and stacking on comet)
 - AutomaticBackgroundExtractor
 - DynamicBackgroundExtractor
 - ScreenTransferFunction + HistogramTransformation (Stretching)
 - StarMask to combine star stacked image with comet stacked image
 - PixelMath to combine the background stars with the comet image
 - CurvesTransformation (some minor tweaks to the colors and further stretching)


**LightRoom:**
 - Increase in vibrance/saturation
 - Boost contrast
 - Noise reduction and Color Noise reduction (to clean up residual star streaks)
 - Slightly bumped Dehaze


 *** 

## Social Accounts: 

- [ChrisGnam](https://www.astrobin.com/users/ChrisGnam/) on Astrobin 
- [chrisgnam.photos](https://www.instagram.com/chrisgnam.photos/) on Instagram 
