
SHELL := /bin/bash

# TOTAL AVAILABLE
POS_COUNT=2700
NEG_COUNT=3019

# How many images to use for training
POS_USE=900
NEG_USE=2900

V_HEIGHT=64
V_WIDTH=64

##### Positive image set creation 
POS_CROPPED_FOLDER=positives
POS_CREATE_PER_CROP=100
POS_INFO=positives_gen.txt
# Where to put the positive images generated
POS_FOLDER=pos_generated
VEC_FILE=samples.vec

##### Negative image set creation
NEG_FOLDER=negatives
NEG_INFO=negatives.txt

#### Training parameters
CLASSIFIER_FOLDER=classifier
NUM_OF_STAGES=20

all:
	echo "Not supported. Please call the specific rule you want to run."

gen_neg_info:
	find $(NEG_FOLDER) > $(NEG_INFO)
	# may need to edit the $(NEG_INFO) file to make sure image list is correct
	# sed -i -e "s/^/$(NEG_FOLDER)\//" $(NEG_INFO)

gen_pos:
	for f in ./$(POS_CROPPED_FOLDER)/*.png; do \
		opencv_createsamples -img $$f -num $(POS_CREATE_PER_CROP) -bg $(NEG_INFO) -info tempfile -maxxangle 0.6 -maxyangle 0.2 -maxzangle 0.00 -maxidev 30 -bgcolor 0 -bgthresh 0 -w $(V_WIDTH) -h $(V_HEIGHT) -pngoutput; \
		cat tempfile >> $(POS_INFO); \
	done
	rm -f tempfile
	mkdir -p $(POS_FOLDER)
	mv *.jpg $(POS_FOLDER)
	sed -i -e "s/^/$(POS_FOLDER)\//" $(POS_INFO)

create_samples:
	opencv_createsamples -info $(POS_INFO) -num $(POS_COUNT) -bg $(NEG_INFO) -vec $(VEC_FILE) -maxangle 0.6 -maxyangle 0.2 -maxzangle 0.01 -maxidev 30 -bgcolor 0 -bgthresh 0 -w $(V_WIDTH) -h $(V_HEIGHT)

view_vector:
	opencv_createsamples -vec $(VEC_FILE) -w $(V_WIDTH) -h $(V_HEIGHT)

train_cascade:
	mkdir -p $(CLASSIFIER_FOLDER)
	opencv_traincascade -numStages $(NUM_OF_STAGES) -data $(CLASSIFIER_FOLDER) -vec $(VEC_FILE) -bg $(NEG_INFO) -minHitRate 0.999 -maxFalseAlarmRate 0.5 -numPos $(POS_USE) -numNeg $(NEG_USE) -w $(V_WIDTH) -h $(V_HEIGHT) -featureType LBP

clean_samples:
	#rm -f $(POS_FOLDER)/*
	#rm -f $(POS_INFO)
	#rm -f $(VEC_FILE) 

clean_classifier:
	rm -rf $(CLASSIFIER_FOLDER)

