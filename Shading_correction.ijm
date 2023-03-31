//Shading_correction.ijm
// 
// This script corrects the Shading for BrighField images
// Author: Sankeert Satheesan, sankeert1999@gmail.com.
// Feb 2023

// Shading Correction

img_title=getTitle();   
rename("BF_1");
run("Duplicate...", "title=BF_2");
run("Gaussian Blur...", "sigma=5");
run("Invert");
imageCalculator("Add create 32-bit", "BF_1","BF_2");

//Pre-Processing
run("Variance...", "radius=5");
run("Mean", "block_radius_x=5 block_radius_y=5");

// Apply threshold
percent=3;
getMinAndMax(min, max);
//min = getMin();
threshold = max * percent / 100;
print(min,max);
setAutoThreshold("Otsu dark");
setThreshold(threshold, max);
run("Convert to Mask");
run("Analyze Particles...", "size=50000-Infinity pixel clear add");
roiManager("Select", 0);
selectWindow("BF_1");
roiManager("Select", 0);
run("Duplicate...", " ");
rename(img_title);
close("\\Others");


outFileName =img_title ; 
outputDir=""
saveAs("Tiff",outputDir+File.separator+outFileName);
roiManager("delete");	//Clearing Out the ROI manager
close("*");
