FROM nvcr.io/nvidia/pytorch:21.07-py3
# bin/bash
SHELL ["/bin/bash", "--login", "-c"]
# Channels Conda
RUN conda install --channel defaults conda python=3.8 --yes
RUN conda config --add channels conda-forge
#RUN conda config --set channel_priority strict
RUN conda init bash
# Copiar dependencias
COPY requirements.txt .
# # # Virtual Enviroment Pytorch 1.9.0 CUDA 11.1
RUN conda create -n torch1.9stable python=3.8

# Dependencias VEnv
RUN /opt/conda/envs/torch1.9stable/bin/pip install -r requirements.txt
RUN /opt/conda/envs/torch1.9stable/bin/pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio===0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
RUN /opt/conda/envs/torch1.9stable/bin/pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://pytorch-geometric.com/whl/torch-1.9.0+cu111.html
RUN /opt/conda/envs/torch1.9stable/bin/ipython kernel install --name torch1.9stable --user --display-name "Pytorch-1.9.0-stable"
# ### JUpyter Widgets
RUN conda install -n base -c conda-forge jupyterlab_widgets
RUN conda install -n torch1.9stable -c conda-forge ipywidgets
# Set Workspace
WORKDIR /home/notebooks


