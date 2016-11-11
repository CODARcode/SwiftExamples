# Comment from Fangfang:
# -- The hyper parameters could initially include the variables in caps such as N1, NE, DR and BATCH.
# -- The metric to optimize would be the validation loss (the lower the better).

import pandas as pd
import numpy as np

from keras.layers import Input, Dense, Dropout
from keras.models import Model


EPOCH = 2
BATCH = 50

P     = 60025    # 245 x 245
N1    = 2000
NE    = 600      # encoded dim
F_MAX = 33.3
DR    = 0.2


def run_one(N1):
    input_vector = Input(shape=(P,))
    x = Dense(N1, activation='sigmoid')(input_vector)
    # x = Dropout(DR)(x)
    x = Dense(NE, activation='sigmoid')(x)
    encoded = x

    x = Dense(N1, activation='sigmoid')(encoded)
    # x = Dropout(DR)(x)
    x = Dense(P, activation='sigmoid')(x)
    decoded = x

    ae = Model(input_vector, decoded)
    #print "autoencoder summary"
    #ae.summary()

    encoded_input = Input(shape=(NE,))
    encoder = Model(input_vector, encoded)
    decoder = Model(encoded_input, ae.layers[-1](ae.layers[-2](encoded_input)))

    train = (pd.read_csv('breast.train.csv').values).astype('float32')
    x_train = train[:, 0:P] / F_MAX

    test = (pd.read_csv('breast.test.csv').values).astype('float32')
    x_test = test[:, 0:P] / F_MAX

    ae.compile(optimizer='rmsprop', loss='mean_squared_error')

    result = ae.fit(x_train, x_train,
                    batch_size=BATCH,
                    nb_epoch=EPOCH,
                    verbose=0, # To avoid printing status during run
                    validation_data=[x_test, x_test])

    print('Results for N1=%s: %s'%(N1,r.history['val_loss']))


for N1 in [100,500,1000,1500,2000,2500,3000]:
    run_one(N1)

    
# Code used to print histogram of result
#encoded_image = encoder.predict(x_test)
#decoded_image = decoder.predict(encoded_image)
#diff = decoded_image - x_test

# diff = ae.predict(x_test) - x_test
#diffs = diff.ravel()

#import matplotlib as mpl
#mpl.use('Agg')
#import matplotlib.pyplot as plt

#plt.hist(diffs, bins='auto')
#plt.title("Histogram of Errors with 'auto' bins")
#plt.savefig('histogram.png')
