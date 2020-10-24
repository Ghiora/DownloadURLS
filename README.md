DownloadURLS

Download Learning Videos #Script is used to download from a URL and convert

Please do not use this code for illegal operations.

I had an error "from Crypto.Cipher import _AES
ImportError: cannot import name _AES
This fixed it: (Ubunut 20.04)
pip install streamlink pycrypto
The following does NOT help
pip install AES Crypto

For example to get a copy of 
Lecture 11 - Introduction to Neural Networks | Stanford CS229: Machine Learning (Autumn 2018)
Run it like this:

download_url.sh -u "https://www.youtube.com/watch?v=MfIjxPh6Pys" -n out1 -m -v


The options are:

-u the URL you want to download

-n the name of the output files + mp3 or mp4

which will be sent to /tmp/

At least one of those must be specified:

-m for mp3 (like music)

-v for mp4 (like video)

