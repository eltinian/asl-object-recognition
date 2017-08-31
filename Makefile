# all paths are relative to current directory
DETECTOR=detector/signdetector

SCALE=--scale=1
CROSS_CASCADE="classifier_crosssign/cascade.xml" 
STOP_CASCADE="classifier_stopsign/cascade.xml" 
CAM_INDEX=0

run_detector:
	$(DETECTOR) $(SCALE) --cross-cascade=$(CROSS_CASCADE) --stop-cascade=$(STOP_CASCADE) $(CAM_INDEX)
