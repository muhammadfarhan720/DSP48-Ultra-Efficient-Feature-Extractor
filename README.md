

**Ultra EnergyEfficient Neuromorphic Processor for ECG Datasets**

This repository presents an ultra lowpower neuromorphic processor designed for classification of ECG signals using a Legendre Delay Network (LDN). The processor is capable of running both in software and hardware implementations, and supports quantization for hardware efficiency.


 📁 **Folder & File Breakdown**

> ⚠️ Make sure the "Data/Data/" folder exists and contains all necessary datasets and spike files. All notebooks rely on this folder being correctly populated.

  **Software Implementation**
 "LSNN_ECG200.ipynb"  
  Software simulation of the processor using a Legendre Delay Network.  
  Includes tunable parameters to evaluate model performance (accuracy, etc).

 "quantized_LSNN_ECG200.ipynb"  
  Prepares quantized input signals ("u[n]") and generates LDN matrices (A and B) used for hardware implementation.

 **Hardware Implementation**
 "LSNN1.xpr"  and "LSNN1.zip"
  Vivado project with SystemVerilog code for hardware implementation.  
  Takes quantized inputs and outputs spike trains to ".csv" files.

 **Evaluation & Analysis**
 "LSNN_HW_accuracies_ECG200_3_readout.ipynb"  
  Loads spike train outputs from the hardware simulation, evaluates performance, and reports metrics such as accuracy and confusion matrix.

 "reservious_accuracies_ECG200.ipynb"  
  Loads spike outputs from a previous hardware accelerator design for comparison against the current neuromorphic processor.



**Dataset**

 The ECG200 dataset is used.
 Make sure all required datasets and generated spike files are inside the "Data/Data/" directory.



**Features**

 Software and hardware implementation of LDNbased processor.
 Support for quantized input and matrix computation.
 Spikebased neuromorphic output processing.
 Comparative performance analysis.

 **Steps to run**
 1. Generate the output spikes from RTL
   ECG200 output spike from hardware :ECG200_results.csv
 3. Load the spike train csv into LSNN_HW_accuracies_ECG200.ipynb
    ECG200_results.csv is read into this python notebook
 5. Run the output layer
    

