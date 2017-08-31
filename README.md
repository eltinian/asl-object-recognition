# asl_object_recognition

Created trained model using OpenCV and haar like features to recognize certain signs in ASL

Requirements: 

1. OpenCV 3.1
2. Negative image set (Can obtain from any repo, etc.)
3. Positive image set (what your object should be reading - in this case, ASL signs) 

Training:  


All steps unless otherwise stated will be performed in the `trainer` folder

1. Fill the `neg_images` folder with all the negative images
2. Fill the `pos_images` folder with the cropped positives images you want to use to generate the positive images to train
3. Edit the `Makefile` (in the trainer folder) variables: 
    * POS/NEG_COUNT (to the total number of positive images to generate/negatives avail)
    * POS/NEG_USE (how many positives and negative images to train with)
4. Preparing the generating the images and image information
    * `make gen_neg_info` (creates the `negatives.info` file)
    * `make gen_pos` (superimposes the `pos_images` onto random negative images to create positive images to use for training)
5. Create the samples vector file 
    * `make create_samples` (creates the `samples.vec` file)
6. Training the cascade 
    * `make train_cascade`
