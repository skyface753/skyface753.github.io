---
layout: post
title: Unity Machine Learning (Mac M1)
date: 2022-06-24
categories: ["Machine Learning", "Mac", "Unity"]
---

First clone the Git repo

```
git clone --branch release_18 https://github.com/Unity-Technologies/ml-agents.git
```

```
conda create -n unity python=3.8.6
conda activate unity
```

Install Python 3.8 and set to primary Path
[Torch Download](https://drive.google.com/file/d/1e-7R3tfyJqv0P4ijZOLDYOleAJ0JrGyJ/view)

```
pip install ~/Downloads/torch-1.8.0a0-cp38-cp38-macosx_11_0_arm64.whl
pip install torchvision
pip install torchaudio

conda install grpcio h5py
```

## In the Git Repo

```
pip install -e ./ml-agents-envs
pip install -e ./ml-agents
```

Install the Unity-Package: Start Unity-Hub Open Project from Downloaded GitHub-Repo: /Project/Assets/ML-Agents/Examples/ „Window“ -> Package Manager Activate ML-Agengs and ML-Agents-Environment

```
mlagents-learn config/ppo/3DBall.yaml --run-id=3DBall01
```

## Hit Play-Button in Unity View the Results:

```
tensorboard --logdir results
```

[Localhost](http://localhost:6006/)

![IMG TEST](/assets/img/TF_ML_Unity_Mac.png)
