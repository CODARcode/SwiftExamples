
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
print "autoencoder summary"
ae.summary()

encoded_input = Input(shape=(NE,))
encoder = Model(input_vector, encoded)
decoder = Model(encoded_input, ae.layers[-1](ae.layers[-2](encoded_input)))

train = (pd.read_csv('breast.train.csv').values).astype('float32')
x_train = train[:, 0:P] / F_MAX

test = (pd.read_csv('breast.test.csv').values).astype('float32')
x_test = test[:, 0:P] / F_MAX

ae.compile(optimizer='rmsprop', loss='mean_squared_error')

ae.fit(x_train, x_train,
       batch_size=BATCH,
       nb_epoch=EPOCH,
       validation_data=[x_test, x_test])

encoded_image = encoder.predict(x_test)
decoded_image = decoder.predict(encoded_image)
diff = decoded_image - x_test

# diff = ae.predict(x_test) - x_test
diffs = diff.ravel()


import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt

plt.hist(diffs, bins='auto')
plt.title("Histogram of Errors with 'auto' bins")
plt.savefig('histogram.png')
