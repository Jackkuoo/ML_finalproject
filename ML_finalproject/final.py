import os, cv2
import numpy as np
np.random.seed(123)
import matplotlib.pyplot as plt
from sklearn.utils import shuffle
from sklearn.cross_validation import train_test_split
from sklearn import preprocessing
from sklearn.metrics import classification_report,confusion_matrix
from keras.utils import np_utils
from keras.models import Sequential,model_from_json,load_model
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout
from keras.optimizers import SGD, adam, RMSprop
import itertools

dataset = []

def image_to_vector(image,size=(32,32)):
    return cv2.resize(image, size).flatten()

for k in range(0,8,1):
    path = "FinalProject_dataset"+ "/" + str(k)
    images = os.listdir(path)
    #print 'load image=',len(images)
    for img in images:
        #print 'load the images of datasets-'+'{}\n'.format(dataset)
        input_img = cv2.imread(path + "/"+img)
        face_cascade = cv2.CascadeClassifier('haarcascades\haarcascade_frontalface_default.xml')
        eye_cascade = cv2.CascadeClassifier('haarcascades\haarcascade_eye.xml')
        input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY)
        #input_img = face_cascade.detectMultiScale(input_img,1.2,6)
        input_img_flatten = image_to_vector(input_img,(32,32))
        dataset.append(input_img_flatten)

img_data = np.array(dataset)
#print img_data.shape
#print type(img_data)

# data pre-processing
x_train = preprocessing.scale(img_data) 
#print X_train.shape
print 'x_train_mean=',np.mean(x_train)
print 'x_train_std=',np.std(x_train)
#print X_train.mean(axis=0)
#print X_train.std(axis=0)


#Define classes
num_classes = 8
num_of_samples = img_data.shape[0]
labels = np.ones((num_of_samples,),dtype='int64')

labels[0:649]=0
labels[650:1479]=1
labels[1480:3067]=2
labels[3068:3945]=3
labels[3946:4719]=4
labels[4720:5721]=5
labels[5722:6931]=6
labels[6932:7384]=7

#names = ['male_child','male_young','male_adult','male_elder','female_child','female_young','femal_adult','female_elder']
Y = np_utils.to_categorical(labels, 8)
print type(Y)
print 'y_shape=',Y.shape
x,y = shuffle(img_data, Y ,random_state=2)
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=4)
print 'xtrain_shape=',x_train.shape
print 'ytrain_shape=',y_train.shape
print 'xtest_shape=',x_test.shape
print 'ytest_shape=',y_test.shape

x_train = x_train.reshape(x_train.shape[0], 32, 32, 1)
x_test = x_test.reshape(x_test.shape[0], 32, 32, 1)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255


# Build CNN
#conv2d(x, kernel, strides=(1, 1), border_mode='valid', dim_ordering='th', image_shape=None, filter_shape=None)
model = Sequential()
model.add(Convolution2D(32,
          kernel_size=(3, 3), 
          activation='relu', 
          #padding='valid',
          input_shape=(32, 32, 1)))
model.add(Convolution2D(32, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(8, activation='softmax'))
# Another way to define your optimizer
adam = adam(lr=1e-4)
# We add metrics to get more results you want to see
model.compile(optimizer='adam',loss='categorical_crossentropy',metrics=['accuracy'])
print '------------ Training ------------'
# train the model
model.fit(x_train, y_train, batch_size=32, epochs=20, verbose=1,validation_data=(x_test, y_test))
print '\n------------ Testing ------------'
# Evaluate the model with the metrics we defined earlier
score = model.evaluate(x_test, y_test, verbose=0)

print '\ntest loss: ', score[0]
print '\ntest accuracy: ', score[1]

x_predict = model.predict(x_test)
y_predict = np.argmax(x_predict,axis=1)
print x_predict
print y_predict

target_names=['0','1','2','3','4','5','6','7']
print classification_report(np.argmax(y_test,axis=1),y_predict,target_names=target_names)
print confusion_matrix(np.argmax(y_test,axis=1),y_predict)


def plot_confusion_matrix(cm,classes,
                          normalize=False,
                          title='Confusion matrix',
                          cmap=plt.cm.Blues):
    plt.imshow(cm,interpolation='nearest',cmap=cmap)
    plt.title(title)
    plt.colorbar()
    tick_marks=np.arange(len(classes))
    plt.xticks(tick_marks,classes,rotation=45)
    plt.yticks(tick_marks,classes)
   
    if normalize:
        cm = cm.astype('float')/cm.sum(axis=1)[:,np.newaxis]
        print 'Normalize confusion matrix'
    else:
        print 'Confusion matrix,without normalization'
    
    print cm

    thresh = cm.max() / 2.
    for i,j in itertools.product(range(cm.shape[0]),range(cm.shape[1])):
        plt.text(j,i,cm[i,j],
            horizontalalignment="center",
            color="white" if cm[i,j] > thresh else "black")
    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predict label')

cnf_matrix = confusion_matrix(np.argmax(y_test,axis=1),y_predict)
plot_confusion_matrix(cnf_matrix,classes=target_names,title='Confusion matrix')

model_json = model.to_json()
with open("model.json","w") as json_file:
    json_file.write(model_json)
'''
# serialize weights to HDF5
model.save_weights("model.hdf5",overwrite=True)
print 'save model'

# load model
json_file = open('model.json','r')
loaded_model_json = json_file.read()
json_file.close()
loaded_model = model_from_json(loaded_model_json)
loaded_model.load_weights("model.h5")
print 'Loaded model'
'''

