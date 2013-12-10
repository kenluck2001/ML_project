Hand writing skill has become innate that we regularly take jottings in diverse situations e.g in classroom. This has caused the large amount of paper documents to be generated on a daily basis. Handwritten character recognition has automated the conversion of manuscripts into digital-based documents. This paper proposes an efficient method for recognizing handwritten images using KNN classification on an input space whose size of data set has been reduced by cluster analysis. The K-medoid algorithm is run to obtain prototypes which are subsequently labelled by a user. The KNN classification is performed between the prototypes and the testing set and appropriate labels are assigned.


This paper proposes an efficient method for recognizing handwritten images using KNN classification on an input space whose data set size has been reduced by cluster analysis. The representative clustering algorithm(K-medoid) is used to reduce the size of the input space to obtain prototypes. These prototypes are the centroids formed by running the clustering algorithm on the data set. Each prototype summarizes the cluster in which it is a centroid. The determination of the optimal number of clusters for the representative clustering algorithm (K-means, K-medoid and EM algorithm) is a known limitation. The representative clustering algorithm outputs clusters irrespective of the number of the specified clusters. This is because the number of clusters can be formed where there is no natural grouping.

However, the optimal number of clusters can be estimated by using cross-validation. The number of clusters is passed as input to the K-medoid algorithm which returns images that are centroids of the clusters. These centroids are assigned appropriate labels by the user after visual inspection.

Code structure
The codes are written in Octave. This procedures are written in different files and function to ensure code modularity. The main files are in src folder. They include:

calError.m	      
mykmeans.m      
pdist2.m	      
store.txt
mykmedoids.m    
randsample.m    
train-images-idx3-ubyte
calnumofclusters.m    
mynewkmeans.m     
loadmnist.m	              
visual.m

mainfunction.m  
run_K_medoid.m
run_knn.m

Most Important Files
mainfunction.m  
This file functions as the main interface to the project. This calls the run_K_medoid function, run_knn function and visual function e.t.c

run_K_medoid.m
This function serves as a wrapper arounf the K-medoid algorithm in mykmedoids.m. This helps structure the code for pedagogical reasons.

run_knn.m
This serves as the implement of the KNN classification where K = 1. The threshold to prevent overconfident classification was not implemented at the moment due to time constraint.

Support Files
train-images-idx3-ubyte
This is the data set provided by MNIST.

calError.m	
This implements the cross-validation routine for estimating the optimal number of clusters.
      
mykmeans.m   
This implements the K-means algorithm.
   
pdist2.m
This is a support file that support vectorization when computing pairwise distances between two vectors. This helped reduce run time in the  calError.m file for calculating the nearest distance between the testing set and centroid.
	      
store.txt
The results of experiment are saved by logging on this file. This was used to save the reduce of the cross-validation routines on the data set.

mykmedoids.m   
This is the implementation of the K-medoid algorithm.
  

calnumofclusters.m   
This iterated through a given range of number of cluster. This is a wrapper around the calError.m file.

mynewkmeans.m   
This is the K-means algorithm that prevent the possibility of having empty clusters. 
  
loadmnist.m	
This is a routine that loads the data set.
              
visual.m
This is a routine that visualizes the data set.
