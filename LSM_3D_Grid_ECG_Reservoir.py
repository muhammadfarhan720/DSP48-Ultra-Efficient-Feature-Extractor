import numpy as np
import self as self



class ReservoirNeuron:


    def __init__(self):

        self.array_4x16 = np.zeros((4, 50))
        self.W_res = np.random.normal(loc=0, scale=0.55, size=(3, 1))
        self.Vmem = 0
        self.Vth = 0.0

        self.W_res = np.where(self.W_res > .5, .5, self.W_res)

        self.W_res = np.where(self.W_res < -.5, -.5, self.W_res)

        print("Initial weights")

        print(self.W_res)


    def shift_columns_right(self, array):

        shifted_array = np.zeros_like(array)
        shifted_array[:, 1:] = array[:, :-1]

        return shifted_array

    def calculate_timing_differences(self, array):
        timing_differences = np.zeros((3, 1), dtype=int)

        for i in range(1, array.shape[0]):
            leading_one_index_first_row = np.argmax(array[0] == 1)
            leading_one_index_current_row = np.argmax(array[i] == 1)

            if array[0, 0] == 1 and array[i, 0] == 1:
                timing_difference = leading_one_index_current_row - leading_one_index_first_row
                timing_differences[i - 1, 0] = timing_difference

        return timing_differences

    def reservoir_neuron(self, spikes_input, Training):
        A_plus = 0.1
        tau_plus = 10.0
        A_minus = 0.1
        tau_minus = 10.0

        Wxs = np.dot(self.W_res.T, spikes_input)

        # print(Wxs)

        tau = 33
        # Vmem = 0
        self.Vmem = self.Vmem - self.Vmem / tau + Wxs

        # print(self.Vmem)

        if self.Vmem > self.Vth:
            spike = 1
            self.Vth = self.Vth - self.Vth / tau + 0.01
            self.Vmem = 0
        else:
            spike = 0
            self.Vth=self.Vth-self.Vth/tau
            if (self.Vmem > 0):
                self.Vmem = self.Vmem - self.Vmem / tau
            elif (self.Vmem < 0):
                self.Vmem = self.Vmem

        self.array_4x16 = self.shift_columns_right(self.array_4x16)
        self.array_4x16[0, 0] = spike

        for i in range(3):
            self.array_4x16[i + 1, 0] = spikes_input[i]

        timing_difference = self.calculate_timing_differences(self.array_4x16)

        # print(timing_difference)

        potentiation = np.where(timing_difference > 0, A_plus * np.exp(-abs(timing_difference) / tau_plus), 0)
        depression = np.where(timing_difference < 0, -A_minus * np.exp(-abs(timing_difference) / tau_minus), 0)

        delta_weight = potentiation + depression
        if (Training == True):

            self.W_res = self.W_res + delta_weight

            self.W_res = np.where(self.W_res > 1.5, 1.5, self.W_res)
            self.W_res = np.where(self.W_res < -1.5, -1.5, self.W_res)


        elif (Training == False):

            self.W_res = self.W_res

        # print(self.W_res)

        return spike


# Example usage
neuron1 = ReservoirNeuron()
neuron2 = ReservoirNeuron()

spikes_input1 = [1, 0, 1]
spikes_input2 = [0, 1, 0]

spike_output1 = neuron1.reservoir_neuron(spikes_input1, True)
spike_output2 = neuron2.reservoir_neuron(spikes_input2, True)

print(spike_output1, spike_output2)

import pandas as pd


train=pd.read_csv(r"C:\Users\azmin\Downloads\ECG5days_test_rate_encoding.csv",header=None)


train = train.astype(int)

train=train.iloc[:,0:136]


Training= True

fd=[]

fd=pd.DataFrame(fd)


neuron1 = ReservoirNeuron()
neuron2 = ReservoirNeuron()
neuron3 = ReservoirNeuron()
neuron4 = ReservoirNeuron()
neuron5 = ReservoirNeuron()
neuron6 = ReservoirNeuron()
neuron7 = ReservoirNeuron()
neuron8 = ReservoirNeuron()
neuron9 = ReservoirNeuron()
neuron10 = ReservoirNeuron()
neuron11 = ReservoirNeuron()
neuron12 = ReservoirNeuron()
neuron13 = ReservoirNeuron()
neuron14 = ReservoirNeuron()
neuron15 = ReservoirNeuron()
neuron16 = ReservoirNeuron()

iteration=40 #training

for k in range(iteration):
  print(f"Simulation Progress: {k}/{iteration}")
  for i in range(861):



    spikes_input1 = [0, 0, 0]
    spikes_input2 = [0, 0, 0]
    spikes_input3 = [0, 0, 0]
    spikes_input4 = [0, 0, 0]
    spikes_input5 = [0, 0, 0]
    spikes_input6 = [0, 0, 0]
    spikes_input7 = [0, 0, 0]
    spikes_input8 = [0, 0, 0]
    spikes_input9 = [0, 0, 0]
    spikes_input10 = [0, 0, 0]
    spikes_input11 = [0, 0, 0]
    spikes_input12 = [0, 0, 0]
    spikes_input13 = [0, 0, 0]
    spikes_input14 = [0, 0, 0]
    spikes_input15 = [0, 0, 0]
    spikes_input16 = [0, 0, 0]


    spike_output1_train=[]

    spike_output2_train=[]

    spike_output3_train=[]
    spike_output4_train=[]
    spike_output5_train=[]
    spike_output6_train=[]
    spike_output7_train=[]
    spike_output8_train=[]
    spike_output9_train=[]
    spike_output10_train=[]
    spike_output11_train=[]
    spike_output12_train=[]
    spike_output13_train=[]
    spike_output14_train=[]
    spike_output15_train=[]
    spike_output16_train=[]



    for j in range(136):





      spikes_input1[0]=train.iloc[i,135-j]
      spikes_input2[0]=train.iloc[i,135-j]
      spikes_input3[0]=train.iloc[i,135-j]
      spikes_input4[0]=train.iloc[i,135-j]
      spikes_input5[0]=train.iloc[i,135-j]
      spikes_input6[0]=train.iloc[i,135-j]
      spikes_input7[0]=train.iloc[i,135-j]
      spikes_input8[0]=train.iloc[i,135-j]
      spikes_input9[0]=train.iloc[i,135-j]
      spikes_input10[0]=train.iloc[i,135-j]
      spikes_input11[0]=train.iloc[i,135-j]
      spikes_input12[0]=train.iloc[i,135-j]
      spikes_input13[0]=train.iloc[i,135-j]
      spikes_input14[0]=train.iloc[i,135-j]
      spikes_input15[0]=train.iloc[i,135-j]
      spikes_input16[0]=train.iloc[i,135-j]


      spike_output1=neuron1.reservoir_neuron(spikes_input1,Training)
      spike_output2=neuron2.reservoir_neuron(spikes_input2,Training)
      spike_output3=neuron3.reservoir_neuron(spikes_input3,Training)
      spike_output4=neuron4.reservoir_neuron(spikes_input4,Training)
      spike_output5=neuron5.reservoir_neuron(spikes_input5,Training)
      spike_output6=neuron6.reservoir_neuron(spikes_input6,Training)
      spike_output7=neuron7.reservoir_neuron(spikes_input7,Training)
      spike_output8=neuron8.reservoir_neuron(spikes_input8,Training)
      spike_output9=neuron9.reservoir_neuron(spikes_input9,Training)
      spike_output10=neuron10.reservoir_neuron(spikes_input10,Training)
      spike_output11=neuron11.reservoir_neuron(spikes_input11,Training)
      spike_output12=neuron12.reservoir_neuron(spikes_input12,Training)
      spike_output13=neuron13.reservoir_neuron(spikes_input13,Training)
      spike_output14=neuron14.reservoir_neuron(spikes_input14,Training)
      spike_output15=neuron15.reservoir_neuron(spikes_input15,Training)
      spike_output16=neuron16.reservoir_neuron(spikes_input16,Training)

      spikes_input1[1]=spike_output1

      spikes_input1[2]=spike_output2

      spikes_input2[1]=spike_output15

      spikes_input2[2]=spike_output12
      spikes_input3[1]=spike_output11

      spikes_input3[2]=spike_output2
      spikes_input4[1]=spike_output5

      spikes_input4[2]=spike_output6
      spikes_input5[1]=spike_output2

      spikes_input5[2]=spike_output7
      spikes_input6[1]=spike_output9

      spikes_input6[2]=spike_output13
      spikes_input7[1]=spike_output10

      spikes_input7[2]=spike_output1
      spikes_input8[1]=spike_output14

      spikes_input8[2]=spike_output12
      spikes_input9[1]=spike_output13

      spikes_input9[2]=spike_output15
      spikes_input10[1]=spike_output11

      spikes_input10[2]=spike_output10
      spikes_input11[1]=spike_output11

      spikes_input11[2]=spike_output15
      spikes_input12[1]=spike_output16

      spikes_input12[2]=spike_output3
      spikes_input13[1]=spike_output5

      spikes_input13[2]=spike_output4
      spikes_input14[1]=spike_output6

      spikes_input14[2]=spike_output7
      spikes_input15[1]=spike_output8

      spikes_input15[2]=spike_output14
      spikes_input16[1]=spike_output12

      spikes_input16[2]=spike_output12



      # spike_output1_train.append(spike_output1)
      # spike_output2_train.append(spike_output2)
      # spike_output3_train.append(spike_output3)
      # spike_output4_train.append(spike_output4)
      # spike_output5_train.append(spike_output5)
      # spike_output6_train.append(spike_output6)
      # spike_output7_train.append(spike_output7)
      # spike_output8_train.append(spike_output8)
      # spike_output9_train.append(spike_output9)
      # spike_output10_train.append(spike_output10)
      # spike_output11_train.append(spike_output11)
      # spike_output12_train.append(spike_output12)
      # spike_output13_train.append(spike_output13)
      # spike_output14_train.append(spike_output14)
      # spike_output15_train.append(spike_output15)
      # spike_output16_train.append(spike_output16)

    # df=np.vstack((spike_output1_train,spike_output2_train,spike_output3_train,spike_output4_train,spike_output5_train,spike_output6_train,spike_output7_train,spike_output8_train,spike_output9_train,spike_output10_train,spike_output11_train,spike_output12_train,spike_output13_train,spike_output14_train,spike_output15_train,spike_output16_train))

    # df=pd.DataFrame(df)

    # fd=pd.concat([fd,df],axis=0,ignore_index=False)
    neuron1.Vmem=0
    neuron1.Vth=0.0
    neuron2.Vmem=0
    neuron2.Vth=0.0
    neuron3.Vmem=0
    neuron3.Vth=0.0
    neuron4.Vmem=0
    neuron4.Vth=0.0
    neuron5.Vmem=0
    neuron5.Vth=0.0
    neuron6.Vmem=0
    neuron6.Vth=0.0
    neuron7.Vmem=0
    neuron7.Vth=0.0
    neuron8.Vmem=0
    neuron8.Vth=0.0
    neuron9.Vmem=0
    neuron9.Vth=0.0
    neuron10.Vmem=0
    neuron10.Vth=0.0
    neuron11.Vmem=0
    neuron11.Vth=0.0
    neuron12.Vmem=0
    neuron12.Vth=0.0
    neuron13.Vmem=0
    neuron13.Vth=0.0
    neuron14.Vmem=0
    neuron14.Vth=0.0
    neuron15.Vmem=0
    neuron15.Vth=0.0
    neuron16.Vmem=0
    neuron16.Vth=0.0



# train.iloc[:,135]



import pandas as pd


train=pd.read_csv(r"C:\Users\azmin\Downloads\ECG5days_test_rate_encoding.csv",header=None)



train=train.iloc[:,0:136]

train

Training= False

# fd=[]

# fd=pd.DataFrame(fd)



# neuron1 = ReservoirNeuron()
# neuron2 = ReservoirNeuron()
# neuron3 = ReservoirNeuron()
# neuron4 = ReservoirNeuron()
# neuron5 = ReservoirNeuron()
# neuron6 = ReservoirNeuron()
# neuron7 = ReservoirNeuron()
# neuron8 = ReservoirNeuron()
# neuron9 = ReservoirNeuron()
# neuron10 = ReservoirNeuron()
# neuron11 = ReservoirNeuron()
# neuron12 = ReservoirNeuron()
# neuron13 = ReservoirNeuron()
# neuron14 = ReservoirNeuron()
# neuron15 = ReservoirNeuron()
# neuron16 = ReservoirNeuron()

iteration=1 #inference

for k in range(iteration):

  #
  # fd=[]
  #
  # fd=pd.DataFrame(fd)

  for i in range(861):



    spikes_input1 = [0, 0, 0]
    spikes_input2 = [0, 0, 0]
    spikes_input3 = [0, 0, 0]
    spikes_input4 = [0, 0, 0]
    spikes_input5 = [0, 0, 0]
    spikes_input6 = [0, 0, 0]
    spikes_input7 = [0, 0, 0]
    spikes_input8 = [0, 0, 0]
    spikes_input9 = [0, 0, 0]
    spikes_input10 = [0, 0, 0]
    spikes_input11 = [0, 0, 0]
    spikes_input12 = [0, 0, 0]
    spikes_input13 = [0, 0, 0]
    spikes_input14 = [0, 0, 0]
    spikes_input15 = [0, 0, 0]
    spikes_input16 = [0, 0, 0]


    spike_output1_train=[]

    spike_output2_train=[]

    spike_output3_train=[]
    spike_output4_train=[]
    spike_output5_train=[]
    spike_output6_train=[]
    spike_output7_train=[]
    spike_output8_train=[]
    spike_output9_train=[]
    spike_output10_train=[]
    spike_output11_train=[]
    spike_output12_train=[]
    spike_output13_train=[]
    spike_output14_train=[]
    spike_output15_train=[]
    spike_output16_train=[]

    for j in range(136):





      spikes_input1[0]=train.iloc[i,135-j]
      spikes_input2[0]=train.iloc[i,135-j]
      spikes_input3[0]=train.iloc[i,135-j]
      spikes_input4[0]=train.iloc[i,135-j]
      spikes_input5[0]=train.iloc[i,135-j]
      spikes_input6[0]=train.iloc[i,135-j]
      spikes_input7[0]=train.iloc[i,135-j]
      spikes_input8[0]=train.iloc[i,135-j]
      spikes_input9[0]=train.iloc[i,135-j]
      spikes_input10[0]=train.iloc[i,135-j]
      spikes_input11[0]=train.iloc[i,135-j]
      spikes_input12[0]=train.iloc[i,135-j]
      spikes_input13[0]=train.iloc[i,135-j]
      spikes_input14[0]=train.iloc[i,135-j]
      spikes_input15[0]=train.iloc[i,135-j]
      spikes_input16[0]=train.iloc[i,135-j]


      spike_output1=neuron1.reservoir_neuron(spikes_input1,Training)
      spike_output2=neuron2.reservoir_neuron(spikes_input2,Training)
      spike_output3=neuron3.reservoir_neuron(spikes_input3,Training)
      spike_output4=neuron4.reservoir_neuron(spikes_input4,Training)
      spike_output5=neuron5.reservoir_neuron(spikes_input5,Training)
      spike_output6=neuron6.reservoir_neuron(spikes_input6,Training)
      spike_output7=neuron7.reservoir_neuron(spikes_input7,Training)
      spike_output8=neuron8.reservoir_neuron(spikes_input8,Training)
      spike_output9=neuron9.reservoir_neuron(spikes_input9,Training)
      spike_output10=neuron10.reservoir_neuron(spikes_input10,Training)
      spike_output11=neuron11.reservoir_neuron(spikes_input11,Training)
      spike_output12=neuron12.reservoir_neuron(spikes_input12,Training)
      spike_output13=neuron13.reservoir_neuron(spikes_input13,Training)
      spike_output14=neuron14.reservoir_neuron(spikes_input14,Training)
      spike_output15=neuron15.reservoir_neuron(spikes_input15,Training)
      spike_output16=neuron16.reservoir_neuron(spikes_input16,Training)

      spikes_input1[1]=spike_output1

      spikes_input1[2]=spike_output2

      spikes_input2[1]=spike_output15

      spikes_input2[2]=spike_output12
      spikes_input3[1]=spike_output11

      spikes_input3[2]=spike_output2
      spikes_input4[1]=spike_output5

      spikes_input4[2]=spike_output6
      spikes_input5[1]=spike_output2

      spikes_input5[2]=spike_output7
      spikes_input6[1]=spike_output9

      spikes_input6[2]=spike_output13
      spikes_input7[1]=spike_output10

      spikes_input7[2]=spike_output1
      spikes_input8[1]=spike_output14

      spikes_input8[2]=spike_output12
      spikes_input9[1]=spike_output13

      spikes_input9[2]=spike_output15
      spikes_input10[1]=spike_output11

      spikes_input10[2]=spike_output10
      spikes_input11[1]=spike_output11

      spikes_input11[2]=spike_output15
      spikes_input12[1]=spike_output16

      spikes_input12[2]=spike_output3
      spikes_input13[1]=spike_output5

      spikes_input13[2]=spike_output4
      spikes_input14[1]=spike_output6

      spikes_input14[2]=spike_output7
      spikes_input15[1]=spike_output8

      spikes_input15[2]=spike_output14
      spikes_input16[1]=spike_output12

      spikes_input16[2]=spike_output12



      spike_output1_train.append(spike_output1)
      spike_output2_train.append(spike_output2)
      spike_output3_train.append(spike_output3)
      spike_output4_train.append(spike_output4)
      spike_output5_train.append(spike_output5)
      spike_output6_train.append(spike_output6)
      spike_output7_train.append(spike_output7)
      spike_output8_train.append(spike_output8)
      spike_output9_train.append(spike_output9)
      spike_output10_train.append(spike_output10)
      spike_output11_train.append(spike_output11)
      spike_output12_train.append(spike_output12)
      spike_output13_train.append(spike_output13)
      spike_output14_train.append(spike_output14)
      spike_output15_train.append(spike_output15)
      spike_output16_train.append(spike_output16)

    df=np.vstack((spike_output1_train,spike_output2_train,spike_output3_train,spike_output4_train,spike_output5_train,spike_output6_train,spike_output7_train,spike_output8_train,spike_output9_train,spike_output10_train,spike_output11_train,spike_output12_train,spike_output13_train,spike_output14_train,spike_output15_train,spike_output16_train))

    df=pd.DataFrame(df)

    fd=pd.concat([fd,df],axis=0,ignore_index=False)

    neuron1.Vmem=0
    neuron1.Vth=0.0
    neuron2.Vmem=0
    neuron2.Vth=0.0
    neuron3.Vmem=0
    neuron3.Vth=0.0
    neuron4.Vmem=0
    neuron4.Vth=0.0
    neuron5.Vmem=0
    neuron5.Vth=0.0
    neuron6.Vmem=0
    neuron6.Vth=0.0
    neuron7.Vmem=0
    neuron7.Vth=0.0
    neuron8.Vmem=0
    neuron8.Vth=0.0
    neuron9.Vmem=0
    neuron9.Vth=0.0
    neuron10.Vmem=0
    neuron10.Vth=0.0
    neuron11.Vmem=0
    neuron11.Vth=0.0
    neuron12.Vmem=0
    neuron12.Vth=0.0
    neuron13.Vmem=0
    neuron13.Vth=0.0
    neuron14.Vmem=0
    neuron14.Vth=0.0
    neuron15.Vmem=0
    neuron15.Vth=0.0
    neuron16.Vmem=0
    neuron16.Vth=0.0





# train.iloc[:,135]


fd=fd.reset_index(drop=True)


pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)


# fd

train=pd.read_csv(r"C:\Users\azmin\Downloads\ECG5days_test_rate_encoding.csv",header=None)

print(train.shape)

for index, row in train.iterrows():
   # fd.loc[136 * index:136 * index + 15, 136] = row[136]
   fd.loc[16 * index:16 * index + 15, 136] = row[136]


fd.to_csv(r'C:\Users\azmin\Downloads\Iteration_40_ECG5days_test_sample_reservoir_states.csv',header=None,index=False)



print(neuron9.W_res)


print(neuron4.W_res)
print(neuron5.W_res)

print(neuron6.W_res)

