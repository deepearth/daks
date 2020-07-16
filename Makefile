overthrust_3D_initial_model.h5: 
	wget ftp://slim.gatech.edu/data/SoftwareRelease/WaveformInversion.jl/3DFWI/overthrust_3D_initial_model.h5

overthrust_3D_true_model_2D.h5: util/slicer.py overthrust_3D_true_model.h5
	python util/slicer.py --filename overthrust_3D_true_model.h5 --datakey m

overthrust_3D_true_model.h5:
	wget ftp://slim.gatech.edu/data/SoftwareRelease/WaveformInversion.jl/3DFWI/overthrust_3D_true_model.h5

overthrust_3D_initial_model_2D.h5: util/slicer.py overthrust_3D_initial_model.h5
	python util/slicer.py --filename overthrust_3D_initial_model.h5 --datakey m0

shots.blob: generate_shot_data.py overthrust_3D_true_model_2D.h5.blob
	python fwi/generate_shot_data.py && touch shots.blob

fwi: shots.blob fwi.py overthrust_3D_initial_model_2D.h5.blob
	python fwi/run.py

overthrust_3D_initial_model.h5.blob: overthrust_3D_initial_model.h5 util/uploader.py
	python util/uploader.py --filename overthrust_3D_initial_model.h5 --container models && touch overthrust_3D_initial_model.h5.blob

overthrust_3D_true_model_2D.h5.blob: overthrust_3D_true_model_2D.h5 util/uploader.py
	python util/uploader.py --filename overthrust_3D_true_model_2D.h5 --container models && touch overthrust_3D_true_model_2D.h5.blob

overthrust_3D_true_model.h5.blob: overthrust_3D_true_model.h5 util/uploader.py
	python util/uploader.py --filename overthrust_3D_true_model.h5 --container models && touch overthrust_3D_true_model.h5.blob

overthrust_3D_initial_model_2D.h5.blob: overthrust_3D_initial_model_2D.h5 util/uploader.py
	python util/uploader.py --filename overthrust_3D_initial_model_2D.h5 --container models && touch overthrust_3D_initial_model_2D.h5.blob
